<?php

namespace Modules\ProviderManagement\Lib;

use Carbon\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

/**
 * Cash-after-service ke baad banne wale pending commission ka calculation.
 *
 * Flow samajhne ke liye:
 *  - Customer cash_after_service choose karta hai -> serviceman customer se
 *    pura cash le leta hai.
 *  - Us cash me se provider edit me set ki hui DONO commissions cut hoti hain:
 *      * admin_commission    (admin ka %  + platform fee)
 *      * provider_commission (provider ka %)
 *    Iske alawa visiting / extra charge (bookings.extra_fee) bhi poora admin
 *    ka hota hai — usme koi commission lagti hi nahi, wo 100% wapas jata hai.
 *    Yahi teen cheezein serviceman ke paas pending rehti hain jo wo provider ko
 *    wapas deta hai. Bacha hua (serviceman_earning) uski apni kamai hai.
 *  - Booking complete hone par ye breakdown booking_details_amounts me snapshot
 *    ban ke store ho jaata hai (BookingTrait::calculateCommissionDetails).
 *
 * Isi liye serviceman ka "pending" = uski completed cash bookings ke
 * (admin_commission + provider_commission + extra_fee) ka sum, jisme se provider
 * ne jo recover kiya (serviceman_cash_collections) use ghata dete hain.
 */
class PendingCollectionService
{
    /** Kitne din tak hisaab clear na hone par "overdue" (red) mana jaye. */
    public const DEFAULT_OVERDUE_DAYS = 4;

    /**
     * Business settings se overdue days lo. Setting na mile to default 4.
     */
    public static function overdueDaysThreshold(): int
    {
        try {
            $value = business_config('pending_collection_overdue_days', 'provider_config')->live_values ?? null;
            if (is_numeric($value) && (int) $value > 0) {
                return (int) $value;
            }
        } catch (\Throwable $e) {
            // setting missing / boot issue -> default hi use karo
        }

        return self::DEFAULT_OVERDUE_DAYS;
    }

    /**
     * Provider ke saare completed cash bookings ki raw rows (per booking), jinse
     * due / serviceman-share nikala jaata hai. Charge-owner logic (admin panel ke
     * "Extra Charge Distribution") per-provider hoti hai, isliye raw rows chahiye.
     *
     * @return Collection<int, object>
     */
    public static function cashBookingRows(string $providerId, ?string $servicemanId = null, ?string $from = null, ?string $to = null): Collection
    {
        return DB::table('bookings as b')
            ->join('booking_details_amounts as a', 'a.booking_id', '=', 'b.id')
            ->where('b.provider_id', $providerId)
            ->where('b.payment_method', 'cash_after_service')
            ->where('b.booking_status', 'completed')
            ->whereNotNull('b.serviceman_id')
            ->whereNull('a.booking_repeat_id')
            ->when($servicemanId, fn($q) => $q->where('b.serviceman_id', $servicemanId))
            ->when($from, fn($q) => $q->whereDate('b.created_at', '>=', $from))
            ->when($to, fn($q) => $q->whereDate('b.created_at', '<=', $to))
            ->select(
                'b.id as booking_id',
                'b.serviceman_id',
                'b.created_at',
                'b.extra_fee',
                'b.total_tax_amount',
                'b.platform_fee',
                'a.admin_commission',
                'a.provider_commission',
                'a.serviceman_earning'
            )
            ->orderBy('b.created_at')
            ->get();
    }

    /**
     * Ek cash booking par serviceman provider ko kitna wapas dega (due) aur uski
     * apni kamai kitni hai — charge-owner setting lagakar.
     *
     * @return array{due: float, serviceman_earning: float}
     */
    public static function bookingDueShare($provider, object $row): array
    {
        $charges = [
            'extra_fee' => (float) ($row->extra_fee ?? 0),
            'tax' => (float) ($row->total_tax_amount ?? 0),
            'platform_fee' => (float) ($row->platform_fee ?? 0) ?: (float) ($provider->platform_fee_amount ?? 0),
        ];

        $adjust = providerBookingChargeDueAdjustment($provider, $charges);

        $due = (float) $row->admin_commission + (float) $row->provider_commission + (float) $row->extra_fee + $adjust['due'];
        $servicemanEarning = (float) $row->serviceman_earning + $adjust['serviceman'];

        return [
            'due' => round(max($due, 0), 2),
            'serviceman_earning' => round(max($servicemanEarning, 0), 2),
        ];
    }

    /**
     * Split the amount due back from a Service Man by its configured owner.
     * Platform fee is already included in the stored commission shares.
     */
    public static function bookingDueBreakdown($provider, object $row): array
    {
        $owners = providerChargeOwners($provider);
        $adminDue = (float) ($row->admin_commission ?? 0);
        $providerDue = (float) ($row->provider_commission ?? 0);
        $extraFee = (float) ($row->extra_fee ?? 0);
        $tax = (float) ($row->total_tax_amount ?? 0);

        if (($owners['extra_fee'] ?? 'admin') === 'admin') {
            $adminDue += $extraFee;
        } elseif (($owners['extra_fee'] ?? 'admin') === 'provider') {
            $providerDue += $extraFee;
        }

        if (($owners['tax'] ?? 'provider') === 'admin') {
            $adminDue += $tax;
        } elseif (($owners['tax'] ?? 'provider') === 'provider') {
            $providerDue += $tax;
        }

        $share = self::bookingDueShare($provider, $row);
        return [
            'due' => $share['due'],
            'admin_due' => round(max($adminDue, 0), 2),
            'provider_due' => round(max($providerDue, 0), 2),
            'serviceman_earning' => $share['serviceman_earning'],
        ];
    }

    /**
     * Provider ke saare completed cash bookings ki kul "due" (jo serviceman
     * wapas dega) serviceman-wise grouped. Charge-owner setting ke hisab se.
     *
     * @return Collection  serviceman_id => due (float)
     */
    public static function dueMap(string $providerId, ?string $from = null, ?string $to = null): Collection
    {
        $provider = DB::table('providers')->where('id', $providerId)->first();
        $rows = self::cashBookingRows($providerId, null, $from, $to);

        return $rows
            ->groupBy('serviceman_id')
            ->map(function ($group) use ($provider) {
                return round($group->sum(fn($row) => self::bookingDueShare($provider, $row)['due']), 2);
            });
    }

    /**
     * Provider ke saare completed cash bookings par serviceman ki kul kamai
     * serviceman-wise grouped (charge-owner setting lagakar).
     *
     * @return Collection  serviceman_id => earning (float)
     */
    public static function servicemanEarningMap(string $providerId, ?string $from = null, ?string $to = null): Collection
    {
        $provider = DB::table('providers')->where('id', $providerId)->first();
        $rows = self::cashBookingRows($providerId, null, $from, $to);

        return $rows
            ->groupBy('serviceman_id')
            ->map(function ($group) use ($provider) {
                return round($group->sum(fn($row) => self::bookingDueShare($provider, $row)['serviceman_earning']), 2);
            });
    }

    /**
     * Provider ne ab tak apne servicemen se jo cash recover kiya.
     *
     * @return Collection  serviceman_id => collected (float)
     */
    public static function collectedMap(string $providerId, ?string $from = null, ?string $to = null): Collection
    {
        return DB::table('serviceman_cash_collections')
            ->where('provider_id', $providerId)
            ->when($from, fn($q) => $q->whereDate('created_at', '>=', $from))
            ->when($to, fn($q) => $q->whereDate('created_at', '<=', $to))
            ->groupBy('serviceman_id')
            ->select('serviceman_id', DB::raw('SUM(amount) as collected'))
            ->pluck('collected', 'serviceman_id');
    }

    /**
     * Provider ke saare servicemen ki booking counts (cash + online dono).
     *
     * @return Collection  serviceman_id => object {total, completed, canceled, ongoing}
     */
    public static function bookingStatsMap(string $providerId): Collection
    {
        $rows = DB::table('bookings')
            ->where('provider_id', $providerId)
            ->whereNotNull('serviceman_id')
            ->groupBy('serviceman_id')
            ->select(
                'serviceman_id',
                DB::raw('COUNT(*) as total'),
                DB::raw("SUM(CASE WHEN booking_status = 'completed' THEN 1 ELSE 0 END) as completed"),
                DB::raw("SUM(CASE WHEN booking_status = 'canceled' THEN 1 ELSE 0 END) as canceled"),
                DB::raw("SUM(CASE WHEN booking_status = 'ongoing' THEN 1 ELSE 0 END) as ongoing")
            )
            ->get();

        return $rows->keyBy('serviceman_id');
    }

    /**
     * FIFO se sabse purani "unsettled" commission ki date nikalo.
     * items ascending order me hone chahiye.
     *
     * @param  array<int, array{date: Carbon, amount: float}>  $items
     */
    public static function oldestUnsettledDate(array $items, float $settled): ?Carbon
    {
        $remaining = $settled;

        foreach ($items as $item) {
            $amount = (float) $item['amount'];
            if ($amount <= 0) {
                continue;
            }

            if ($remaining >= $amount) {
                $remaining -= $amount;
                continue;
            }

            // Ye booking pura settle nahi hui -> yahi sabse purani pending hai
            return $item['date'];
        }

        return null;
    }

    /**
     * Kisi ek serviceman ki commission entries (booking-wise) ascending date order me.
     * Har entry = us booking ki due (charge-owner setting lagakar).
     *
     * @return Collection<int, object>
     */
    public static function servicemanCommissionEntries(string $providerId, string $servicemanId, ?string $from = null, ?string $to = null): Collection
    {
        $provider = DB::table('providers')->where('id', $providerId)->first();

        return self::cashBookingRows($providerId, $servicemanId, $from, $to)
            ->map(function ($row) use ($provider) {
                $share = self::bookingDueShare($provider, $row);
                return (object) [
                    'booking_id' => $row->booking_id,
                    'created_at' => $row->created_at,
                    'amount' => $share['due'],
                    'serviceman_earning' => $share['serviceman_earning'],
                ];
            })
            ->values();
    }

    /**
     * Ek serviceman ka poora pending snapshot (date range optional).
     *
     * @return array
     */
    public static function servicemanSnapshot(string $providerId, string $servicemanId, ?string $from = null, ?string $to = null): array
    {
        $due = (float) (self::dueMap($providerId, $from, $to)[$servicemanId] ?? 0);
        $collected = (float) (self::collectedMap($providerId, $from, $to)[$servicemanId] ?? 0);
        $pending = round(max($due - $collected, 0), 2);
        $earning = (float) (self::servicemanEarningMap($providerId, $from, $to)[$servicemanId] ?? 0);

        $entries = self::servicemanCommissionEntries($providerId, $servicemanId, $from, $to);
        $items = $entries->map(fn($e) => [
            'date' => Carbon::parse($e->created_at),
            'amount' => (float) $e->amount,
        ])->all();

        $oldestAt = self::oldestUnsettledDate($items, $collected);
        $overdueDays = $oldestAt ? (int) $oldestAt->diffInDays(Carbon::now()) : 0;
        $threshold = self::overdueDaysThreshold();

        return [
            'due' => round($due, 2),
            'collected' => round($collected, 2),
            'pending' => $pending,
            'earning' => round($earning, 2),
            'oldest_pending_at' => $oldestAt,
            'overdue_days' => $overdueDays,
            'is_overdue' => $oldestAt !== null && $overdueDays >= $threshold,
            'threshold' => $threshold,
        ];
    }

    /**
     * Admin side: provider par kitne din se pending pada hua hai.
     * FIFO: payable_commission credits vs kul paid_commission (collect).
     */
    public static function providerPendingSince(string $providerId): ?Carbon
    {
        $providerUserId = DB::table('providers')->where('id', $providerId)->value('user_id');
        if (!$providerUserId) {
            return null;
        }

        $entries = DB::table('transactions')
            ->where('from_user_id', $providerUserId)
            ->whereIn('trx_type', ['payable_commission', 'payable_extra_fee', 'payable_tax'])
            ->orderBy('created_at')
            ->select('created_at', 'credit as amount')
            ->get();

        $settled = (float) DB::table('transactions')
            ->where('from_user_id', $providerUserId)
            ->where('trx_type', 'paid_commission')
            ->sum('debit');

        $items = $entries->map(fn($e) => [
            'date' => Carbon::parse($e->created_at),
            'amount' => (float) $e->amount,
        ])->all();

        return self::oldestUnsettledDate($items, $settled);
    }

    /**
     * Provider ke servicemen ki list + pending breakdown (paginated).
     *
     * @return array{total:int, last_page:int, data:array}
     */
    public static function servicemanPendingList(
        string $providerId,
        ?string $from = null,
        ?string $to = null,
        string $search = '',
        int $limit = 10,
        int $offset = 1,
        ?string $status = null
    ): array {
        $base = DB::table('servicemen as s')
            ->join('users as u', 'u.id', '=', 's.user_id')
            ->where('s.provider_id', $providerId)
            ->where('u.user_type', 'provider-serviceman')
            ->whereNull('s.deleted_at')
            ->when($search !== '', function ($q) use ($search) {
                $keys = explode(' ', $search);
                $q->where(function ($sub) use ($keys) {
                    foreach ($keys as $key) {
                        $sub->orWhere('u.first_name', 'LIKE', '%' . $key . '%')
                            ->orWhere('u.last_name', 'LIKE', '%' . $key . '%')
                            ->orWhere('u.phone', 'LIKE', '%' . $key . '%')
                            ->orWhere('u.email', 'LIKE', '%' . $key . '%');
                    }
                });
            })
            ->when($status !== null && $status !== 'all', function ($q) use ($status) {
                $q->where('u.is_active', $status === 'active' ? 1 : 0);
            });

        $total = (clone $base)->count();

        $rows = $base
            ->orderBy('u.first_name')
            ->offset(max($offset - 1, 0) * $limit)
            ->limit($limit)
            ->select(
                's.id as serviceman_id',
                's.created_at as joined_at',
                'u.first_name',
                'u.last_name',
                'u.phone',
                'u.email',
                'u.profile_image',
                'u.is_active'
            )
            ->get();

        $due = self::dueMap($providerId, $from, $to);
        $collected = self::collectedMap($providerId, $from, $to);
        $earnings = self::servicemanEarningMap($providerId, $from, $to);
        $stats = self::bookingStatsMap($providerId);
        $threshold = self::overdueDaysThreshold();

        $data = $rows->map(function ($row) use ($providerId, $from, $to, $due, $collected, $earnings, $stats, $threshold) {
            $entries = self::servicemanCommissionEntries($providerId, $row->serviceman_id, $from, $to);
            $collectedAmount = (float) ($collected[$row->serviceman_id] ?? 0);
            $dueAmount = (float) ($due[$row->serviceman_id] ?? 0);
            $earningAmount = (float) ($earnings[$row->serviceman_id] ?? 0);

            $items = $entries->map(fn($e) => [
                'date' => Carbon::parse($e->created_at),
                'amount' => (float) $e->amount,
            ])->all();

            $oldestAt = self::oldestUnsettledDate($items, $collectedAmount);
            $overdueDays = $oldestAt ? (int) $oldestAt->diffInDays(Carbon::now()) : 0;
            $stat = $stats[$row->serviceman_id] ?? null;

            return [
                'serviceman_id' => $row->serviceman_id,
                'name' => trim(($row->first_name ?? '') . ' ' . ($row->last_name ?? '')),
                'first_name' => $row->first_name,
                'last_name' => $row->last_name,
                'phone' => $row->phone,
                'email' => $row->email,
                'profile_image' => $row->profile_image,
                'profile_image_full_path' => $row->profile_image
                    ? getSingleImageFullPath(imagePath: 'serviceman/profile/' . $row->profile_image, s3Storage: null, defaultPath: null)
                    : null,
                'is_active' => (int) $row->is_active,
                'joined_at' => $row->joined_at,
                'total_bookings' => (int) ($stat->total ?? 0),
                'completed_bookings' => (int) ($stat->completed ?? 0),
                'canceled_bookings' => (int) ($stat->canceled ?? 0),
                'ongoing_bookings' => (int) ($stat->ongoing ?? 0),
                'due_amount' => round($dueAmount, 2),
                'collected_amount' => round($collectedAmount, 2),
                'pending_amount' => round(max($dueAmount - $collectedAmount, 0), 2),
                'earning_amount' => round($earningAmount, 2),
                'oldest_pending_at' => $oldestAt?->toDateTimeString(),
                'overdue_days' => $overdueDays,
                'is_overdue' => $oldestAt !== null && $overdueDays >= $threshold,
            ];
        })->values()->all();

        return [
            'total' => $total,
            'last_page' => $limit > 0 ? (int) ceil($total / $limit) : 1,
            'data' => $data,
        ];
    }
}

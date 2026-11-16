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
 *  - Booking complete hone par provider ke account_payable me admin_commission
 *    (+ extra fee) add ho jaati hai (TRX_TYPE: payable_commission / payable_extra_fee)
 *    aur provider ke received_balance me sirf booking_amount_without_commission
 *    aata hai.
 *  - Matlab jo hissa provider ke received_balance me nahi aaya (commission +
 *    extra fee) wahi serviceman ke paas pending rehta hai aur wahi serviceman
 *    provider ko wapas deta hai.
 *
 * Isi liye serviceman ka "pending" = uski cash bookings ki payable_commission +
 * payable_extra_fee ka sum, jisme se provider ne jo recover kiya use ghata dete hain.
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
     * Provider ke saare cash bookings ki payable commission + extra fee,
     * serviceman-wise grouped.
     *
     * @return Collection  serviceman_id => due (float)
     */
    public static function dueMap(string $providerId, ?string $from = null, ?string $to = null): Collection
    {
        return DB::table('transactions as t')
            ->join('bookings as b', 'b.id', '=', 't.booking_id')
            ->where('b.provider_id', $providerId)
            ->where('b.payment_method', 'cash_after_service')
            ->whereNotNull('b.serviceman_id')
            ->whereIn('t.trx_type', ['payable_commission', 'payable_extra_fee'])
            ->when($from, fn($q) => $q->whereDate('t.created_at', '>=', $from))
            ->when($to, fn($q) => $q->whereDate('t.created_at', '<=', $to))
            ->groupBy('b.serviceman_id')
            ->select('b.serviceman_id', DB::raw('SUM(t.credit) as due'))
            ->pluck('due', 'serviceman_id');
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
     *
     * @return Collection<int, object>
     */
    public static function servicemanCommissionEntries(string $providerId, string $servicemanId, ?string $from = null, ?string $to = null): Collection
    {
        return DB::table('transactions as t')
            ->join('bookings as b', 'b.id', '=', 't.booking_id')
            ->where('b.provider_id', $providerId)
            ->where('b.serviceman_id', $servicemanId)
            ->where('b.payment_method', 'cash_after_service')
            ->whereIn('t.trx_type', ['payable_commission', 'payable_extra_fee'])
            ->when($from, fn($q) => $q->whereDate('t.created_at', '>=', $from))
            ->when($to, fn($q) => $q->whereDate('t.created_at', '<=', $to))
            ->groupBy('t.booking_id', 't.created_at')
            ->select('t.booking_id', 't.created_at', DB::raw('SUM(t.credit) as amount'))
            ->orderBy('t.created_at')
            ->get();
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
            ->whereIn('trx_type', ['payable_commission', 'payable_extra_fee'])
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
        $stats = self::bookingStatsMap($providerId);
        $threshold = self::overdueDaysThreshold();

        $data = $rows->map(function ($row) use ($providerId, $from, $to, $due, $collected, $stats, $threshold) {
            $entries = self::servicemanCommissionEntries($providerId, $row->serviceman_id, $from, $to);
            $collectedAmount = (float) ($collected[$row->serviceman_id] ?? 0);
            $dueAmount = (float) ($due[$row->serviceman_id] ?? 0);

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

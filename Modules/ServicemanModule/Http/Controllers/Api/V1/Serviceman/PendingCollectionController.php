<?php

namespace Modules\ServicemanModule\Http\Controllers\Api\V1\Serviceman;

use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Modules\ProviderManagement\Lib\PendingCollectionService;
use Modules\UserManagement\Entities\Serviceman;

/**
 * Serviceman app -> "Earnings / Pending" tab.
 *
 * Cash-after-service bookings par serviceman customer se pura cash leta hai.
 * Usme se jo hissa uska nahi hai (provider + admin ka) wo usse provider ko
 * wapas dena hota hai. Ye controller wo hisaab dikhata hai:
 *   - kitna paisa provider ko dena hai (due)
 *   - kitna de diya (collected)
 *   - kitna pending
 *   - per booking: uski kamai + provider ko kitna dena hai
 *
 * Charge-owner (admin panel: "Extra Charge Distribution") ka asar bhi in amounts
 * me hai — jo charge serviceman ke naam set hua ho wo uski kamai me jud jaata hai.
 */
class PendingCollectionController extends Controller
{
    private Serviceman $serviceman;

    public function __construct(Serviceman $serviceman)
    {
        $this->serviceman = $serviceman;
    }

    /**
     * Top blocks — total earning, total due, paid, pending, next due date.
     */
    public function summary(Request $request): JsonResponse
    {
        $serviceman = $this->currentServiceman($request);
        if (!$serviceman) {
            return response()->json(response_formatter(DEFAULT_204), 204);
        }

        $provider = DB::table('providers')->where('id', $serviceman->provider_id)->first();
        $threshold = PendingCollectionService::overdueDaysThreshold();

        $snapshot = PendingCollectionService::servicemanSnapshot($serviceman->provider_id, $serviceman->id);

        $completedCashBookings = DB::table('bookings')
            ->where('provider_id', $serviceman->provider_id)
            ->where('serviceman_id', $serviceman->id)
            ->where('payment_method', 'cash_after_service')
            ->where('booking_status', 'completed')
            ->count();

        $nextDueAt = $snapshot['oldest_pending_at']
            ? Carbon::parse($snapshot['oldest_pending_at'])->addDays($threshold)
            : null;

        $paymentHistory = DB::table('serviceman_cash_collections')
            ->where('provider_id', $serviceman->provider_id)
            ->where('serviceman_id', $serviceman->id)
            ->orderByDesc('created_at')
            ->limit(50)
            ->get(['id', 'amount', 'note', 'created_at']);

        return response()->json(response_formatter(DEFAULT_200, [
            'total_earning' => (float) $snapshot['earning'],
            'total_due' => (float) $snapshot['due'],
            'total_paid' => (float) $snapshot['collected'],
            'pending_amount' => (float) $snapshot['pending'],
            'completed_cash_bookings' => $completedCashBookings,
            'overdue_days' => (int) $snapshot['overdue_days'],
            'is_overdue' => (bool) $snapshot['is_overdue'],
            'overdue_days_threshold' => $threshold,
            'next_due_date' => $nextDueAt?->toDateString(),
            'payment_history' => $paymentHistory,
            'currency_symbol' => currency_symbol(),
        ]), 200);
    }

    /**
     * Per-booking list — earning + provider ko kitna dena hai (paginated).
     * FIFO: provider ne jo ab tak recover kiya (collected) wo sabse purani
     * bookings par pehle adjust hoti hai, isliye har row settle/pending dikhati hai.
     */
    public function index(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'sometimes|numeric|min:1|max:200',
            'offset' => 'sometimes|numeric|min:1|max:100000',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $serviceman = $this->currentServiceman($request);
        if (!$serviceman) {
            return response()->json(response_formatter(DEFAULT_204), 204);
        }

        $provider = DB::table('providers')->where('id', $serviceman->provider_id)->first();
        $threshold = PendingCollectionService::overdueDaysThreshold();

        $limit = (int) ($request['limit'] ?? 10);
        $offset = (int) ($request['offset'] ?? 1);

        // Poori list (ascending) — FIFO settle marking ke liye saari rows chahiye.
        $allRows = $this->bookingRowsQuery($serviceman)
            ->orderBy('b.created_at')
            ->get();

        $collected = (float) DB::table('serviceman_cash_collections')
            ->where('provider_id', $serviceman->provider_id)
            ->where('serviceman_id', $serviceman->id)
            ->sum('amount');

        // FIFO: collected ko purani bookings par adjust karo
        $remaining = $collected;
        $marked = [];
        foreach ($allRows as $row) {
            $share = PendingCollectionService::bookingDueShare($provider, (object) [
                'extra_fee' => $row->extra_fee,
                'total_tax_amount' => $row->total_tax_amount,
                'admin_commission' => $row->admin_commission,
                'provider_commission' => $row->provider_commission,
                'serviceman_earning' => $row->serviceman_earning,
            ]);

            $due = $share['due'];
            if ($remaining >= $due) {
                $remaining -= $due;
                $pending = 0.0;
            } else {
                $pending = round(max($due - $remaining, 0), 2);
                $remaining = 0.0;
            }

            $dueAt = $row->created_at ? Carbon::parse($row->created_at)->addDays($threshold) : null;

            $marked[] = [
                'booking_id' => $row->id,
                'readable_id' => $row->readable_id,
                'service_name' => $row->sub_category_name ?? $row->category_name,
                'category_name' => $row->category_name,
                'booking_date' => $row->created_at,
                'collected_from_customer' => round((float) $row->total_booking_amount, 2),
                'your_earning' => $share['serviceman_earning'],
                'provider_due' => $due,
                'paid_to_provider' => round(max($due - $pending, 0), 2),
                'pending_amount' => $pending,
                'is_settled' => $pending <= 0,
                'due_date' => $dueAt?->toDateString(),
                'is_overdue' => $pending > 0 && $dueAt !== null
                    && $dueAt->isPast() && $dueAt->diffInDays(Carbon::now()) >= $threshold,
            ];
        }

        // Table: purani (pending) pehle dikhaao
        $data = array_reverse($marked);

        $total = count($data);
        $sliced = array_slice($data, max($offset - 1, 0) * $limit, $limit);

        return response()->json(response_formatter(DEFAULT_200, [
            'total' => $total,
            'last_page' => $limit > 0 ? (int) ceil($total / $limit) : 1,
            'data' => array_values($sliced),
            'currency_symbol' => currency_symbol(),
        ]), 200);
    }

    /**
     * Ek booking ka poora hisaab — "your amount" + charge breakdown.
     */
    public function show(Request $request, string $id): JsonResponse
    {
        $serviceman = $this->currentServiceman($request);
        if (!$serviceman) {
            return response()->json(response_formatter(DEFAULT_204), 204);
        }

        $row = $this->bookingRowsQuery($serviceman)->where('b.id', $id)->first();
        if (!$row) {
            return response()->json(response_formatter(DEFAULT_204), 204);
        }

        $provider = DB::table('providers')->where('id', $serviceman->provider_id)->first();
        $threshold = PendingCollectionService::overdueDaysThreshold();

        $share = PendingCollectionService::bookingDueShare($provider, (object) [
            'extra_fee' => $row->extra_fee,
            'total_tax_amount' => $row->total_tax_amount,
            'platform_fee' => $row->platform_fee ?? 0,
            'admin_commission' => $row->admin_commission,
            'provider_commission' => $row->provider_commission,
            'serviceman_earning' => $row->serviceman_earning,
        ]);

        // Charge breakdown — kaun sa charge kis ko gaya
        $chargeAmounts = [
            'extra_fee' => (float) $row->extra_fee,
            'tax' => (float) $row->total_tax_amount,
            'platform_fee' => (float) ($row->platform_fee ?? 0) ?: (float) ($provider->platform_fee_amount ?? 0),
        ];
        $owners = providerChargeOwners($provider);
        $chargeBreakdown = [];
        foreach (providerChargeTypes() as $key => $meta) {
            $chargeBreakdown[] = [
                'key' => $key,
                'label' => $meta['label'],
                'amount' => round($chargeAmounts[$key] ?? 0, 2),
                'owner' => $owners[$key] ?? $meta['default'],
                'owner_label' => chargeOwnerOptions()[$owners[$key] ?? $meta['default']] ?? '',
                'goes_to_serviceman' => ($owners[$key] ?? $meta['default']) === 'serviceman',
            ];
        }

        $dueAt = $row->created_at ? Carbon::parse($row->created_at)->addDays($threshold) : null;

        // Existing bulk receipts FIFO allocate karke is booking ki actual
        // paid amount aur receipt dates dikhate hain.
        $allBookingRows = $this->bookingRowsQuery($serviceman)->orderBy('b.created_at')->get();
        $collectionRows = DB::table('serviceman_cash_collections')
            ->where('provider_id', $serviceman->provider_id)
            ->where('serviceman_id', $serviceman->id)
            ->orderBy('created_at')->orderBy('id')
            ->get(['id', 'amount', 'note', 'created_at']);
        $dueRemaining = [];
        foreach ($allBookingRows as $bookingRow) {
            $bookingShare = PendingCollectionService::bookingDueShare($provider, (object) [
                'extra_fee' => $bookingRow->extra_fee,
                'total_tax_amount' => $bookingRow->total_tax_amount,
                'platform_fee' => $bookingRow->platform_fee ?? 0,
                'admin_commission' => $bookingRow->admin_commission,
                'provider_commission' => $bookingRow->provider_commission,
                'serviceman_earning' => $bookingRow->serviceman_earning,
            ]);
            $dueRemaining[] = (float) $bookingShare['due'];
        }

        $paidToProvider = 0.0;
        $paymentHistory = [];
        $bookingIndex = 0;
        foreach ($collectionRows as $receipt) {
            $left = round((float) $receipt->amount, 2);
            while ($left > 0.009 && $bookingIndex < $allBookingRows->count()) {
                if ($dueRemaining[$bookingIndex] <= 0.009) {
                    $bookingIndex++;
                    continue;
                }
                $allocated = round(min($left, $dueRemaining[$bookingIndex]), 2);
                if ($allBookingRows[$bookingIndex]->id === $row->id) {
                    $paidToProvider = round($paidToProvider + $allocated, 2);
                    $paymentHistory[] = [
                        'id' => (string) $receipt->id,
                        'amount' => $allocated,
                        'note' => $receipt->note,
                        'created_at' => (string) $receipt->created_at,
                    ];
                }
                $left = round($left - $allocated, 2);
                $dueRemaining[$bookingIndex] = round($dueRemaining[$bookingIndex] - $allocated, 2);
                if ($dueRemaining[$bookingIndex] <= 0.009) {
                    $bookingIndex++;
                }
            }
        }

        return response()->json(response_formatter(DEFAULT_200, [
            'booking' => [
                'id' => $row->id,
                'readable_id' => $row->readable_id,
                'service_name' => $row->sub_category_name ?? $row->category_name,
                'category_name' => $row->category_name,
                'booking_status' => $row->booking_status,
                'payment_method' => $row->payment_method,
                'booking_date' => $row->created_at,
                'collected_from_customer' => round((float) $row->total_booking_amount, 2),
            ],
            'your_amount' => $share['serviceman_earning'],
            'admin_commission' => round((float) $row->admin_commission, 2),
            'provider_commission' => round((float) $row->provider_commission, 2),
            'provider_due' => $share['due'],
            'paid_to_provider' => $paidToProvider,
            'payment_history' => $paymentHistory,
            'due_date' => $dueAt?->toDateString(),
            'overdue_days_threshold' => $threshold,
            'charge_breakdown' => $chargeBreakdown,
            'currency_symbol' => currency_symbol(),
        ]), 200);
    }

    /**
     * Serviceman ki completed cash bookings (names ke saath) — base query.
     */
    private function bookingRowsQuery($serviceman)
    {
        return DB::table('bookings as b')
            ->join('booking_details_amounts as a', 'a.booking_id', '=', 'b.id')
            ->leftJoin('categories as sc', 'sc.id', '=', 'b.sub_category_id')
            ->leftJoin('categories as mc', 'mc.id', '=', 'b.category_id')
            ->where('b.provider_id', $serviceman->provider_id)
            ->where('b.serviceman_id', $serviceman->id)
            ->where('b.payment_method', 'cash_after_service')
            ->where('b.booking_status', 'completed')
            ->whereNull('a.booking_repeat_id')
            ->select(
                'b.id',
                'b.readable_id',
                'b.created_at',
                'b.booking_status',
                'b.payment_method',
                'b.total_booking_amount',
                'b.extra_fee',
                'b.total_tax_amount',
                'b.platform_fee',
                'sc.name as sub_category_name',
                'mc.name as category_name',
                'a.admin_commission',
                'a.provider_commission',
                'a.serviceman_earning'
            );
    }

    /**
     * Logged-in serviceman ka record.
     */
    private function currentServiceman(Request $request)
    {
        return $this->serviceman
            ->where('user_id', $request->user()->id)
            ->first();
    }
}

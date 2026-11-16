<?php

namespace Modules\ProviderManagement\Http\Controllers\Api\V1\Provider;

use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Modules\ProviderManagement\Entities\ServicemanCashCollection;
use Modules\ProviderManagement\Lib\PendingCollectionService;
use Modules\UserManagement\Entities\Serviceman;
use Modules\UserManagement\Entities\User;

/**
 * Provider app -> "Pending Collection" tab.
 *
 * Cash-after-service bookings par serviceman ke paas jo commission pending
 * rehta hai uski serviceman-wise list, date filter, detail aur recovery.
 */
class PendingCollectionController extends Controller
{
    private Serviceman $serviceman;
    private User $user;
    private ServicemanCashCollection $collection;

    public function __construct(Serviceman $serviceman, User $user, ServicemanCashCollection $collection)
    {
        $this->serviceman = $serviceman;
        $this->user = $user;
        $this->collection = $collection;
    }

    /**
     * Top summary — total pending, overdue count etc.
     */
    public function summary(Request $request): JsonResponse
    {
        $provider = $request->user()->provider;
        [$from, $to] = $this->dateRange($request);

        $list = PendingCollectionService::servicemanPendingList($provider->id, $from, $to, '', 100000, 1, 'all');

        $totalPending = 0;
        $totalDue = 0;
        $totalCollected = 0;
        $overdueCount = 0;

        foreach ($list['data'] as $row) {
            $totalPending += (float) $row['pending_amount'];
            $totalDue += (float) $row['due_amount'];
            $totalCollected += (float) $row['collected_amount'];
            if ($row['is_overdue']) {
                $overdueCount++;
            }
        }

        $providerPayable = (float) ($provider->owner?->account?->account_payable ?? 0);

        return response()->json(response_formatter(DEFAULT_200, [
            'total_pending' => round($totalPending, 2),
            'total_due' => round($totalDue, 2),
            'total_collected' => round($totalCollected, 2),
            'provider_payable' => round($providerPayable, 2),
            'total_servicemen' => $list['total'],
            'overdue_servicemen' => $overdueCount,
            'overdue_days_threshold' => PendingCollectionService::overdueDaysThreshold(),
            'currency_symbol' => currency_symbol(),
        ]), 200);
    }

    /**
     * Serviceman-wise pending list (date range + search + pagination).
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

        $provider = $request->user()->provider;
        [$from, $to] = $this->dateRange($request);

        $search = $request->has('string') && !empty($request['string'])
            ? base64_decode($request['string'])
            : ($request['search'] ?? '');

        $result = PendingCollectionService::servicemanPendingList(
            $provider->id,
            $from,
            $to,
            (string) $search,
            (int) ($request['limit'] ?? 10),
            (int) ($request['offset'] ?? 1),
            $request['status'] ?? 'all'
        );

        return response()->json(response_formatter(DEFAULT_200, $result), 200);
    }

    /**
     * Ek serviceman ka poora data — bookings, earning, pending, history, reviews.
     */
    public function servicemanDetail(Request $request, string $id): JsonResponse
    {
        $provider = $request->user()->provider;

        $serviceman = $this->serviceman->with('user')
            ->where('id', $id)
            ->where('provider_id', $provider->id)
            ->first();

        if (!isset($serviceman)) {
            return response()->json(response_formatter(DEFAULT_204), 204);
        }

        [$from, $to] = $this->dateRange($request);
        $snapshot = PendingCollectionService::servicemanSnapshot($provider->id, $serviceman->id, $from, $to);

        // Booking counts (cash + online dono)
        $statusRows = DB::table('bookings')
            ->where('provider_id', $provider->id)
            ->where('serviceman_id', $serviceman->id)
            ->select('booking_status', DB::raw('COUNT(*) as total'))
            ->groupBy('booking_status')
            ->pluck('total', 'booking_status');

        $bookingCount = [
            'total' => (int) $statusRows->sum(),
            'completed' => (int) ($statusRows['completed'] ?? 0),
            'canceled' => (int) ($statusRows['canceled'] ?? 0),
            'ongoing' => (int) ($statusRows['ongoing'] ?? 0),
        ];

        // Earning (cash + online) — provider ko jo received_amount mila uske hisaab se
        $earning = DB::table('transactions as t')
            ->join('bookings as b', 'b.id', '=', 't.booking_id')
            ->where('b.provider_id', $provider->id)
            ->where('b.serviceman_id', $serviceman->id)
            ->where('t.trx_type', 'received_amount')
            ->select(
                DB::raw("SUM(CASE WHEN b.payment_method = 'cash_after_service' THEN t.credit ELSE 0 END) as cash_earning"),
                DB::raw("SUM(CASE WHEN b.payment_method <> 'cash_after_service' THEN t.credit ELSE 0 END) as online_earning"),
                DB::raw('SUM(t.credit) as total_earning')
            )
            ->first();

        // Reviews
        $reviewStats = DB::table('reviews')
            ->where('provider_id', $provider->id)
            ->where('serviceman_id', $serviceman->id)
            ->select(DB::raw('COUNT(*) as total'), DB::raw('AVG(review_rating) as average'))
            ->first();

        $recentReviews = DB::table('reviews')
            ->where('provider_id', $provider->id)
            ->where('serviceman_id', $serviceman->id)
            ->orderByDesc('created_at')
            ->limit(10)
            ->select('id', 'review_rating', 'review_comment', 'created_at')
            ->get();

        // Booking history paginated
        $limit = (int) ($request['history_limit'] ?? 20);
        $offset = (int) ($request['history_offset'] ?? 1);
        $history = $this->servicemanHistory($provider->id, $serviceman->id, $from, $to, $limit, $offset);

        $collections = $this->collection
            ->where('provider_id', $provider->id)
            ->where('serviceman_id', $serviceman->id)
            ->latest()
            ->limit(50)
            ->get();

        return response()->json(response_formatter(DEFAULT_200, [
            'serviceman' => [
                'id' => $serviceman->id,
                'name' => trim(($serviceman->user->first_name ?? '') . ' ' . ($serviceman->user->last_name ?? '')),
                'first_name' => $serviceman->user->first_name ?? null,
                'last_name' => $serviceman->user->last_name ?? null,
                'phone' => $serviceman->user->phone ?? null,
                'email' => $serviceman->user->email ?? null,
                'profile_image_full_path' => $serviceman->user->profile_image_full_path ?? null,
                'is_active' => (int) ($serviceman->user->is_active ?? 0),
                'joined_at' => $serviceman->created_at,
            ],
            'booking_count' => $bookingCount,
            'earning' => [
                'cash_earning' => round((float) ($earning->cash_earning ?? 0), 2),
                'online_earning' => round((float) ($earning->online_earning ?? 0), 2),
                'total_earning' => round((float) ($earning->total_earning ?? 0), 2),
            ],
            'pending' => [
                'due_amount' => $snapshot['due'],
                'collected_amount' => $snapshot['collected'],
                'pending_amount' => $snapshot['pending'],
                'oldest_pending_at' => $snapshot['oldest_pending_at']?->toDateTimeString(),
                'overdue_days' => $snapshot['overdue_days'],
                'is_overdue' => $snapshot['is_overdue'],
                'overdue_days_threshold' => $snapshot['threshold'],
            ],
            'reviews' => [
                'total_reviews' => (int) ($reviewStats->total ?? 0),
                'average_rating' => round((float) ($reviewStats->average ?? 0), 1),
                'recent' => $recentReviews,
            ],
            'history' => $history['data'],
            'history_pagination' => [
                'total' => $history['total'],
                'last_page' => $history['last_page'],
            ],
            'collections' => $collections,
            'currency_symbol' => currency_symbol(),
        ]), 200);
    }

    /**
     * Provider ne serviceman se cash recover kiya -> ledger entry.
     */
    public function collect(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'serviceman_id' => 'required|exists:servicemen,id',
            'amount' => 'required|numeric|min:1',
            'note' => 'sometimes|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $provider = $request->user()->provider;
        $serviceman = $this->serviceman
            ->where('id', $request['serviceman_id'])
            ->where('provider_id', $provider->id)
            ->first();

        if (!isset($serviceman)) {
            return response()->json(response_formatter(DEFAULT_204), 204);
        }

        $snapshot = PendingCollectionService::servicemanSnapshot($provider->id, $serviceman->id);

        if ((float) $request['amount'] > $snapshot['pending']) {
            return response()->json(response_formatter(DEFAULT_400, null, [[
                'error_code' => 'amount',
                'message' => translate('Amount can not be greater than pending balance'),
            ]]), 400);
        }

        $this->collection->create([
            'provider_id' => $provider->id,
            'serviceman_id' => $serviceman->id,
            'amount' => (float) $request['amount'],
            'collected_by' => $request->user()->id,
            'note' => $request['note'] ?? null,
        ]);

        return response()->json(response_formatter(DEFAULT_STORE_200, [
            'pending_amount' => round(max($snapshot['pending'] - (float) $request['amount'], 0), 2),
        ]), 200);
    }

    /**
     * Serviceman ko active / inactive karo (pending hisaab clear na karne par).
     */
    public function toggleStatus(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'serviceman_id' => 'required|exists:servicemen,id',
            'is_active' => 'sometimes|in:0,1',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $provider = $request->user()->provider;
        $serviceman = $this->serviceman
            ->with('user')
            ->where('id', $request['serviceman_id'])
            ->where('provider_id', $provider->id)
            ->first();

        if (!isset($serviceman) || !isset($serviceman->user)) {
            return response()->json(response_formatter(DEFAULT_204), 204);
        }

        $serviceman->user->is_active = $request->has('is_active')
            ? (int) $request['is_active']
            : ($serviceman->user->is_active == 1 ? 0 : 1);
        $serviceman->user->save();

        return response()->json(response_formatter(DEFAULT_200, [
            'serviceman_id' => $serviceman->id,
            'is_active' => (int) $serviceman->user->is_active,
        ]), 200);
    }

    /**
     * Serviceman ki booking history + commission + earning (paginated).
     *
     * @return array{total:int, last_page:int, data:array}
     */
    private function servicemanHistory(string $providerId, string $servicemanId, ?string $from, ?string $to, int $limit, int $offset): array
    {
        $commissionSub = DB::table('transactions')
            ->select('booking_id', DB::raw('SUM(credit) as commission_amount'))
            ->whereIn('trx_type', ['payable_commission', 'payable_extra_fee'])
            ->whereNotNull('booking_id')
            ->groupBy('booking_id');

        $earningSub = DB::table('transactions')
            ->select('booking_id', DB::raw('SUM(credit) as earning_amount'))
            ->where('trx_type', 'received_amount')
            ->whereNotNull('booking_id')
            ->groupBy('booking_id');

        $base = DB::table('bookings as b')
            ->where('b.provider_id', $providerId)
            ->where('b.serviceman_id', $servicemanId)
            ->when($from, fn($q) => $q->whereDate('b.created_at', '>=', $from))
            ->when($to, fn($q) => $q->whereDate('b.created_at', '<=', $to));

        $total = (clone $base)->count();

        $rows = $base
            ->leftJoinSub($commissionSub, 'c', 'c.booking_id', '=', 'b.id')
            ->leftJoinSub($earningSub, 'e', 'e.booking_id', '=', 'b.id')
            ->leftJoin('categories as sc', 'sc.id', '=', 'b.sub_category_id')
            ->leftJoin('categories as mc', 'mc.id', '=', 'b.category_id')
            ->orderByDesc('b.created_at')
            ->offset(max($offset - 1, 0) * $limit)
            ->limit($limit)
            ->select(
                'b.id',
                'b.readable_id',
                'b.booking_status',
                'b.payment_method',
                'b.total_booking_amount',
                'b.is_paid',
                'b.created_at',
                'sc.name as sub_category_name',
                'mc.name as category_name',
                DB::raw('COALESCE(c.commission_amount, 0) as commission_amount'),
                DB::raw('COALESCE(e.earning_amount, 0) as earning_amount')
            )
            ->get();

        return [
            'total' => $total,
            'last_page' => $limit > 0 ? (int) ceil($total / $limit) : 1,
            'data' => $rows,
        ];
    }

    /**
     * Optional date range (from / to). Dono optional — na ho to all time.
     *
     * @return array{0: ?string, 1: ?string}
     */
    private function dateRange(Request $request): array
    {
        $from = $request['from'] ?? null;
        $to = $request['to'] ?? null;

        try {
            $from = $from ? Carbon::parse($from)->toDateString() : null;
            $to = $to ? Carbon::parse($to)->toDateString() : null;
        } catch (\Throwable $e) {
            $from = null;
            $to = null;
        }

        return [$from, $to];
    }
}

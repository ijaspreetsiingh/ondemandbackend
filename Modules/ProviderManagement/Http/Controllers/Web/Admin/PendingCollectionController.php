<?php

namespace Modules\ProviderManagement\Http\Controllers\Web\Admin;

use Brian2694\Toastr\Facades\Toastr;
use Carbon\Carbon;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Modules\ProviderManagement\Entities\Provider;
use Modules\ProviderManagement\Lib\PendingCollectionService;
use Modules\UserManagement\Entities\User;
use \Illuminate\Foundation\Auth\Access\AuthorizesRequests;

/**
 * Admin panel -> "Provider Pending Amount Collect".
 *
 * Cash-after-service se jo admin commission provider par pending banti hai
 * (account_payable) uski provider-wise list + detail + collect.
 */
class PendingCollectionController extends Controller
{
    use AuthorizesRequests;

    protected Provider $provider;
    protected User $user;

    public function __construct(Provider $provider, User $user)
    {
        $this->provider = $provider;
        $this->user = $user;
    }

    /**
     * Provider-wise pending list.
     */
    public function index(Request $request): Renderable
    {
        $this->authorize('provider_view');

        $search = $request->get('search', '');
        $showAll = $request->get('filter') === 'all';

        $providers = $this->provider
            ->with(['owner.account'])
            ->when($search !== '', function ($query) use ($search) {
                $keys = explode(' ', $search);
                $query->where(function ($q) use ($keys) {
                    foreach ($keys as $key) {
                        $q->orWhere('company_name', 'LIKE', '%' . $key . '%')
                            ->orWhere('company_phone', 'LIKE', '%' . $key . '%')
                            ->orWhere('id', 'LIKE', '%' . $key . '%');
                    }
                });
            })
            ->when(!$showAll, function ($query) {
                $query->whereHas('owner.account', fn($q) => $q->where('account_payable', '>', 0));
            })
            ->orderByDesc('created_at')
            ->paginate(pagination_limit())
            ->appends(['search' => $search, 'filter' => $request->get('filter')]);

        $stats = $this->providerStats($providers->pluck('id')->all());
        $threshold = PendingCollectionService::overdueDaysThreshold();

        $totalPending = (float) $this->user
            ->where('user_type', PROVIDER_USER_TYPES[0])
            ->join('accounts', 'accounts.user_id', '=', 'users.id')
            ->sum('accounts.account_payable');

        return view('providermanagement::admin.pending-collection.index',
            compact('providers', 'stats', 'search', 'threshold', 'showAll', 'totalPending'));
    }

    /**
     * Ek provider ka detail — serviceman-wise pending, bookings, reviews.
     */
    public function show($provider_id, Request $request): Renderable|RedirectResponse
    {
        $this->authorize('provider_view');

        $provider = $this->provider->with(['owner.account', 'zone'])->find($provider_id);
        if (!isset($provider)) {
            Toastr::error(translate(DEFAULT_404['message']));
            return back();
        }

        [$from, $to] = $this->dateRange($request);

        $servicemen = PendingCollectionService::servicemanPendingList(
            $provider->id, $from, $to, '', 200, 1, 'all'
        )['data'];

        $pendingAmount = (float) ($provider->owner?->account?->account_payable ?? 0);
        $pendingSince = PendingCollectionService::providerPendingSince($provider->id);
        $overdueDays = $pendingSince ? (int) $pendingSince->diffInDays(Carbon::now()) : 0;
        $threshold = PendingCollectionService::overdueDaysThreshold();

        $bookingStats = DB::table('bookings')
            ->where('provider_id', $provider->id)
            ->select('booking_status', DB::raw('COUNT(*) as total'))
            ->groupBy('booking_status')
            ->pluck('total', 'booking_status');

        // Serviceman-wise rating (review uske naam ke saath dikhega)
        $servicemanRatings = DB::table('reviews')
            ->where('provider_id', $provider->id)
            ->whereNotNull('serviceman_id')
            ->select('serviceman_id', DB::raw('COUNT(*) as total'), DB::raw('AVG(review_rating) as average'))
            ->groupBy('serviceman_id')
            ->get()->keyBy('serviceman_id');

        foreach ($servicemen as &$row) {
            $rating = $servicemanRatings[$row['serviceman_id']] ?? null;
            $row['total_reviews'] = (int) ($rating->total ?? 0);
            $row['average_rating'] = round((float) ($rating->average ?? 0), 1);
        }
        unset($row);

        $reviews = DB::table('reviews as r')
            ->leftJoin('servicemen as s', 's.id', '=', 'r.serviceman_id')
            ->leftJoin('users as u', 'u.id', '=', 's.user_id')
            ->where('r.provider_id', $provider->id)
            ->orderByDesc('r.created_at')
            ->limit(20)
            ->select(
                'r.id', 'r.review_rating', 'r.review_comment', 'r.created_at',
                'u.first_name as serviceman_first_name', 'u.last_name as serviceman_last_name'
            )
            ->get();

        $reviewSummary = DB::table('reviews')
            ->where('provider_id', $provider->id)
            ->select(DB::raw('COUNT(*) as total'), DB::raw('AVG(review_rating) as average'))
            ->first();

        // Konsi-konsi service provider ke servicemen ne deliver ki (with bookings)
        $services = DB::table('bookings as b')
            ->leftJoin('categories as sc', 'sc.id', '=', 'b.sub_category_id')
            ->leftJoin('categories as mc', 'mc.id', '=', 'b.category_id')
            ->where('b.provider_id', $provider->id)
            ->when($from, fn($q) => $q->whereDate('b.created_at', '>=', $from))
            ->when($to, fn($q) => $q->whereDate('b.created_at', '<=', $to))
            ->select(
                DB::raw("COALESCE(sc.name, '-') as service_name"),
                DB::raw("COALESCE(mc.name, '-') as category_name"),
                DB::raw('COUNT(*) as total'),
                DB::raw("SUM(CASE WHEN b.booking_status = 'completed' THEN 1 ELSE 0 END) as completed")
            )
            ->groupBy('sc.name', 'mc.name')
            ->orderByDesc('total')
            ->get();

        $totalServicemanPending = array_sum(array_column($servicemen, 'pending_amount'));

        return view('providermanagement::admin.pending-collection.show', compact(
            'provider',
            'servicemen',
            'pendingAmount',
            'pendingSince',
            'overdueDays',
            'threshold',
            'bookingStats',
            'reviews',
            'reviewSummary',
            'services',
            'totalServicemanPending',
        ));
    }

    /**
     * Admin provider se pending commission collect karta hai.
     */
    public function collectCash(Request $request): RedirectResponse
    {
        $this->authorize('provider_update');

        $validator = Validator::make($request->all(), [
            'provider_id' => 'required|exists:providers,id',
            'amount' => 'required|numeric|min:1',
        ]);

        if ($validator->fails()) {
            Toastr::error(translate('Amount is required and must be greater than 0'));
            return back();
        }

        $providerUserId = get_user_id($request['provider_id'], PROVIDER_USER_TYPES[0]);
        $providerUser = $this->user->with(['account'])->find($providerUserId);

        if (is_null($providerUser) || is_null($providerUser->account)) {
            Toastr::error(translate(DEFAULT_404['message']));
            return back();
        }

        if ($request['amount'] > $providerUser->account->account_payable) {
            Toastr::error(translate(COLLECT_CASH_FAIL_200['message']));
            return back();
        }

        collectCashTransaction($request->provider_id, $request['amount']);

        Toastr::success(translate(COLLECT_CASH_SUCCESS_200['message']));
        return back();
    }

    /**
     * Provider-wise ek saath stats (booking counts, serviceman count, pending since).
     *
     * @param  array<int, string>  $providerIds
     */
    private function providerStats(array $providerIds): array
    {
        if (empty($providerIds)) {
            return [];
        }

        $bookings = DB::table('bookings')
            ->whereIn('provider_id', $providerIds)
            ->select(
                'provider_id',
                DB::raw('COUNT(*) as total'),
                DB::raw("SUM(CASE WHEN booking_status = 'completed' THEN 1 ELSE 0 END) as completed")
            )
            ->groupBy('provider_id')
            ->get()->keyBy('provider_id');

        $servicemen = DB::table('servicemen')
            ->whereIn('provider_id', $providerIds)
            ->whereNull('deleted_at')
            ->select('provider_id', DB::raw('COUNT(*) as total'))
            ->groupBy('provider_id')
            ->get()->keyBy('provider_id');

        $stats = [];
        foreach ($providerIds as $id) {
            $pendingSince = PendingCollectionService::providerPendingSince($id);
            $overdueDays = $pendingSince ? (int) $pendingSince->diffInDays(Carbon::now()) : 0;

            $stats[$id] = [
                'total_bookings' => (int) ($bookings[$id]->total ?? 0),
                'completed_bookings' => (int) ($bookings[$id]->completed ?? 0),
                'servicemen' => (int) ($servicemen[$id]->total ?? 0),
                'pending_since' => $pendingSince,
                'overdue_days' => $overdueDays,
            ];
        }

        return $stats;
    }

    /**
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

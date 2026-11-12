<?php

namespace Modules\PromotionManagement\Http\Controllers\Api\V1\Customer;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\BookingModule\Entities\Booking;
use Modules\CartModule\Entities\Cart;
use Modules\PromotionManagement\Entities\Coupon;
use Modules\PromotionManagement\Entities\CouponCustomer;
use Modules\PromotionManagement\Entities\Discount;
use Modules\PromotionManagement\Entities\DiscountType;
use Modules\ServiceManagement\Entities\Service;

class CouponController extends Controller
{
    protected $discount, $coupon, $discountType, $cart, $service, $couponCustomer, $booking;
    private bool $is_customer_logged_in;
    private mixed $customer_user_id;

    public function __construct(Coupon $coupon, CouponCustomer $couponCustomer, Discount $discount, DiscountType $discountType, Cart $cart, Service $service, Booking $booking, Request $request)
    {
        $this->discount = $discount;
        $this->discountQuery = $discount->ofPromotionTypes('coupon');
        $this->coupon = $coupon;
        $this->couponCustomer = $couponCustomer;
        $this->discountType = $discountType;
        $this->cart = $cart;
        $this->service = $service;
        $this->booking = $booking;

        $this->is_customer_logged_in = (bool)auth('api')->user();
        $this->customer_user_id = $this->is_customer_logged_in ? auth('api')->user()->id : $request['guest_id'];
    }


    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function index(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $activeCoupons = $this->coupon->with(['discount', 'coupon_customers'])
            ->when(!is_null($request->status), function ($query) use ($request) {
                $query->ofStatus(1);
            })
            ->whereHas('discount', function ($query) {
                $query->where(['promotion_type' => 'coupon'])
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->where('is_active', 1);
            })
            ->whereHas('discount.discount_types', function ($query) {
                $query->where(['discount_type' => 'zone', 'type_wise_id' => config('zone_id')]);
            })
            ->where(function ($query) use ($request) {
                $query->where(function ($query) use ($request) {
                        $query->where('coupon_type', '<>', 'customer_wise')
                            ->orWhereHas('coupon_customers', function ($query) use ($request) {
                                $query->where('customer_user_id', $this->customer_user_id);
                            });
                    })
                    ->orWhereHas('coupon_customers', function ($query) use ($request) {
                        $query->where('customer_user_id', $this->customer_user_id);
                    });
            })
            ->paginate($request->limit, ['*'], 'page', $request->page);

        foreach ($activeCoupons as $key => $coupon) {
            $coupon['is_used'] = Cart::where('customer_id', $this->customer_user_id)
                ->where('coupon_code', $coupon->coupon_code)
                ->exists() ? 1 : 0;

            $usedCount = $this->booking
                ->where('customer_id', $this->customer_user_id)
                ->where('coupon_code', $coupon->coupon_code)
                ->count();

            $coupon['used_count'] = $usedCount;
            $coupon['remaining_uses'] = max(0, (int)($coupon->discount->limit_per_user ?? 0) - $usedCount);
            // App builds `remaintng_uses` (typo) padhte hain — dono keys bhejo.
            $coupon['remaintng_uses'] = $coupon['remaining_uses'];
        }

        $expiredCoupons = $this->coupon->with(['discount'])
            ->when(!is_null($request->status), function ($query) use ($request) {
                $query->ofStatus(1);
            })
            ->whereHas('discount', function ($query) {
                $query->where(['promotion_type' => 'coupon'])
                    ->whereDate('end_date', '<', now())
                    ->where('is_active', 1);
            })
            ->whereHas('discount.discount_types', function ($query) {
                $query->where(['discount_type' => 'zone', 'type_wise_id' => config('zone_id')]);
            })->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        foreach ($expiredCoupons as $key => $coupon) {
            $coupon['is_used'] = 0;
            $coupon['remaining_uses'] = 0;
            $coupon['remaintng_uses'] = 0;
        }

        return response()->json(response_formatter(DEFAULT_200, [
            'active_coupons' => $activeCoupons,
            'expired_coupons' => $expiredCoupons,
            // Purane app builds isi (typo) key ko padhte hain. Ye key na hone par
            // app ka coupon list parse hi nahi hota tha (spinner hamesha ghoomta tha).
            'exptred_coupons' => $expiredCoupons,
        ]), 200);
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function applicable(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $couponQuery = $this->coupon
            ->with(['discount.discount_types'])
            ->ofStatus(1)
            ->whereHas('discount', function ($query) {
                $query->where(['promotion_type' => 'coupon'])
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->where('is_active', 1);
            })
            ->whereHas('discount.discount_types', function ($query) {
                $query->where(['discount_type' => 'zone', 'type_wise_id' => config('zone_id')]);
            })->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        $cartItems = $this->cart->where(['customer_id' => $this->customer_user_id])->get();

        if ($cartItems->count() < 1)  return response()->json(response_formatter(DEFAULT_404, []), 404);

        $typeWiseId = [];
        foreach ($cartItems as $item) {
            $typeWiseId['service_ids'][] = $item['service_id'];
            $typeWiseId['category_ids'][] = $item['category_id'];
        }

        $filteredCoupons = collect([]);
        foreach ($couponQuery as $key=>$coupon) {
            //provider wise
            $couponProviderIds = collect($coupon->discount->discount_types)->where('discount_type', 'provider')->pluck('type_wise_id');
            if ($couponProviderIds->isNotEmpty()) {
                $cartProviderIds = $cartItems->pluck('provider_id')->filter()->unique();
                if ($couponProviderIds->intersect($cartProviderIds)->isEmpty()) {
                    continue;
                }
            }

            //category wise
            if ($coupon->discount->discount_type == 'category') {
                $categoryIds = collect($coupon->discount->discount_types)->where('discount_type', 'category')->pluck('type_wise_id');
                if (collect($typeWiseId['category_ids'])->intersect($categoryIds)->isNotEmpty()) {
                    $filteredCoupons->push($couponQuery[$key]);
                }
            }

            //service wise
            if ($coupon->discount->discount_type == 'service') {
                $serviceIds = collect($coupon->discount->discount_types)->where('discount_type', 'service')->pluck('type_wise_id');
                if (collect($typeWiseId['service_ids'])->intersect($serviceIds)->isNotEmpty()) {
                    $filteredCoupons->push($couponQuery[$key]);
                }
            }

            //mixed
            if ($coupon->discount->discount_type == 'mixed') {
                $serviceIds = collect($coupon->discount->discount_types)->whereIn('discount_type', ['category', 'service'])->pluck('type_wise_id');
                if (collect(array_merge($typeWiseId['service_ids'], $typeWiseId['category_ids']))->intersect($serviceIds)->isNotEmpty()) {
                    $filteredCoupons->push($couponQuery[$key]);
                }
            }
        }

        foreach ($filteredCoupons as $key => $coupon) {
            $filteredCoupons[$key]['is_used'] = Cart::where('customer_id', $this->customer_user_id)->where('coupon_code', $coupon->coupon_code)->exists() ? 1 : 0;
        }


        if ($filteredCoupons->count() < 1)  return response()->json(response_formatter(DEFAULT_404, []), 404);

        return response()->json(response_formatter(DEFAULT_200, $filteredCoupons), 200);
    }

    /**
     * Show the form for creating a new resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function applyCoupon(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'coupon_code' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $cartItems = $this->cart->where(['customer_id' => $this->customer_user_id])->get();
        $typeWiseId = [];
        foreach ($cartItems as $item) {
            $typeWiseId['service_ids'][] = $item['service_id'];
            $typeWiseId['category_ids'][] = $item['category_id'];
        }

        //find valid coupons
        $couponQuery = $this->coupon->where(['coupon_code' => $request['coupon_code']])
            ->withoutGlobalScope('zone_wise_data')
            ->with(['discount'])
            ->whereHas('discount', function ($query) {
                $query->where('promotion_type', 'coupon')->where('is_active', 1)
                    ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now());
            });

        // Zone, Category & service check
        $zoneCheck = $couponQuery->whereHas('discount.discount_types', function ($query) {
            $query->where(['discount_type' => DISCOUNT_TYPE['zone'], 'type_wise_id' => config('zone_id')]);
        })->exists();
        if (!$zoneCheck) return response()->json(response_formatter(COUPON_NOT_VALID_FOR_ZONE), 200);

        foreach ($couponQuery->with(['discount.discount_types'])->get() as $coupon) {
            //provider wise
            $couponProviderIds = collect($coupon->discount->discount_types)->where('discount_type', 'provider')->pluck('type_wise_id');
            if ($couponProviderIds->isNotEmpty()) {
                $cartProviderIds = $cartItems->pluck('provider_id')->filter()->unique();
                if ($couponProviderIds->intersect($cartProviderIds)->isEmpty()) {
                    return response()->json(response_formatter(COUPON_NOT_VALID_FOR_PROVIDER), 200);
                }
            }

            //category wise
            if ($coupon->discount->discount_type == 'category') {
                $categoryIds = collect($coupon->discount->discount_types)->where('discount_type', 'category')->pluck('type_wise_id');
                if (collect($typeWiseId['category_ids'])->intersect($categoryIds)->isEmpty()) {
                    return response()->json(response_formatter(COUPON_NOT_VALID_FOR_CATEGORY), 200);
                }
            }

            //service wise
            if ($coupon->discount->discount_type == 'service') {
                $serviceIds = collect($coupon->discount->discount_types)->where('discount_type', 'service')->pluck('type_wise_id');
                if (collect($typeWiseId['service_ids'])->intersect($serviceIds)->isEmpty()) {
                    return response()->json(response_formatter(COUPON_NOT_VALID_FOR_SERVICE), 200);
                }
            }

            //mixed
            if ($coupon->discount->discount_type == 'mixed') {
                $serviceIds = collect($coupon->discount->discount_types)->whereIn('discount_type', ['category', 'service'])->pluck('type_wise_id');

                if (collect(array_merge($typeWiseId['service_ids'], $typeWiseId['category_ids']))->intersect($serviceIds)->isEmpty()) {
                    return response()->json(response_formatter(COUPON_NOT_VALID_FOR_CATEGORY), 200);
                }
            }
        }

        $coupon = $couponQuery->latest()->first();

        if (!isset($coupon)) {
            return response()->json(response_formatter(DEFAULT_404), 200);
        }

        // Sirf category/service ids hi discount target hain. Pehle zone aur
        // provider ids bhi isme aa jate the, jisse koi bhi cart item match nahi
        // hota tha aur coupon "not valid for cart" bol deta tha.
        $discountedIds = ($coupon->discount && $coupon->discount->discount_types->count() > 0)
            ? $coupon->discount->discount_types
                ->whereIn('discount_type', ['category', 'service'])
                ->pluck('type_wise_id')->toArray()
            : [];

        //coupon type check
        if ($coupon->coupon_type == 'first_booking') {
            $bookings = $this->booking->where('customer_id', $this->customer_user_id)->count();
            if ($bookings > 1) {
                return response()->json(response_formatter(COUPON_IS_VALID_FOR_FIRST_TIME), 200);
            }
        } else if ($coupon->coupon_type == 'customer_wise') {
            $couponCustomer = $this->couponCustomer
                ->where('coupon_id', $coupon->id)
                ->where('customer_user_id', $this->customer_user_id)
                ->exists();
            if (!$couponCustomer) {
                return response()->json(response_formatter(COUPON_NOT_VALID_FOR_CART), 200);
            }
        }

        //coupon limit check
        $repeatCount = $this->booking->where('customer_id', $this->customer_user_id)
            ->where('coupon_code', $coupon['coupon_code'])
            ->get()
            ->sum(function ($booking) use ($coupon) {
                $repeatCount = $booking->repeat()
                    ->where('coupon_code', $coupon['coupon_code'])
                    ->count();

                return $repeatCount > 0 ? $repeatCount : 1;
            });

        $totalUsedCount = $repeatCount;

        if ($coupon->coupon_type != 'first_booking' && $totalUsedCount >= (int)($coupon->discount->limit_per_user ?? 0)) {
            return response()->json(response_formatter(COUPON_NOT_VALID_FOR_CART), 200);
        }

        if ($coupon->coupon_type == 'first_booking') {
            $limit = $this->booking
                ->where('customer_id', $this->customer_user_id)
                ->where('booking_status', '!=', 'canceled')
                ->count();
            if ($limit >= (int)($coupon->discount->limit_per_user ?? 0)) {
                return response()->json(response_formatter(COUPON_NOT_VALID_FOR_CART), 200);
            }
        }

        // Minimum purchase cart ke TOTAL par check hota hai (per-item nahi).
        $cartSubtotal = 0;
        foreach ($cartItems as $item) {
            $cartSubtotal += $item->service_cost * $item['quantity'];
        }
        $minPurchase = (float) ($coupon->discount->min_purchase ?? 0);
        if ($minPurchase > 0 && round($cartSubtotal, 2) < $minPurchase) {
            return response()->json([
                'response_code' => 'coupon_not_valid_for_your_cart',
                'message' => translate('This coupon needs a minimum order of') . ' ' . with_currency_symbol($minPurchase),
                'content' => null,
                'errors' => [],
            ], 200);
        }

        // Purana coupon pehle hata do — coupon badalne par purana discount
        // chipka nahi rehna chahiye. Base amounts dobara calculate hote hain.
        foreach ($cartItems as $item) {
            $service = $this->service->find($item['service_id']);
            $subtotal = round($item->service_cost * $item['quantity'], 2);
            $applicableDiscount = max((float) $item->discount_amount, (float) $item->campaign_discount);
            $effectiveTaxPercent = providerEffectiveTaxPercent($item->provider, (float) ($service['tax'] ?? 0));
            $tax = round((($subtotal - $applicableDiscount) * $effectiveTaxPercent) / 100, 2);

            $item->coupon_discount = 0;
            $item->coupon_code = null;
            $item->coupon_id = 0;
            $item->tax_amount = $tax;
            $item->total_cost = round($subtotal - $applicableDiscount + $tax, 2);
            $item->save();
        }

        //apply
        $applied = 0;
        $totalCouponDiscount = 0;
        foreach ($cartItems as $item) {
            if (!in_array($item->service_id, $discountedIds) && !in_array($item->category_id, $discountedIds)) {
                continue;
            }

            if (!discount_applies_to_provider($coupon->discount, $item->provider_id)) {
                continue;
            }

            $cartItem = $this->cart->where('id', $item['id'])->first();
            if (!$cartItem) {
                continue;
            }

            $service = $this->service->find($cartItem['service_id']);
            $subtotal = round($cartItem->service_cost * $cartItem['quantity'], 2);
            $applicableDiscount = max((float) $cartItem->discount_amount, (float) $cartItem->campaign_discount);
            $couponDiscountAmount = booking_discount_calculator($coupon->discount, $subtotal - $applicableDiscount);

            // Discount 0 bana (item-level min purchase poori nahi hui) to
            // "applied" mat bolo — warna user ko "coupon applied" dikhta tha
            // par discount ₹0 rehta tha.
            if ($couponDiscountAmount <= 0) {
                continue;
            }

            $effectiveTaxPercent = providerEffectiveTaxPercent($cartItem->provider, (float) ($service['tax'] ?? 0));
            $tax = round((($subtotal - $applicableDiscount - $couponDiscountAmount) * $effectiveTaxPercent) / 100, 2);

            //update carts table
            $cartItem->coupon_discount = $couponDiscountAmount;
            $cartItem->coupon_code = $coupon->coupon_code;
            $cartItem->coupon_id = $coupon->id;
            $cartItem->tax_amount = $tax;
            $cartItem->total_cost = round($subtotal - $applicableDiscount - $couponDiscountAmount + $tax, 2);
            $cartItem->save();

            $applied = 1;
            $totalCouponDiscount += $couponDiscountAmount;
        }

        if ($applied) {
            return response()->json(response_formatter(COUPON_APPLIED_200, [
                'coupon_code' => $coupon->coupon_code,
                'coupon_discount' => round($totalCouponDiscount, 2),
            ]), 200);
        }
        return response()->json(response_formatter(COUPON_NOT_VALID_FOR_CART), 200);

    }

    /**
     * Show the form for creating a new resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function removeCoupon(Request $request): JsonResponse
    {
        $cartItems = $this->cart->where('customer_id', $this->customer_user_id)->get();
        if ($cartItems->isEmpty()) {
            return response()->json(response_formatter(DEFAULT_UPDATE_200), 200);
        }

        foreach ($cartItems as $cart) {
            $service = $this->service->find($cart['service_id']);

            $basicDiscount = $cart->discount_amount;
            $campaignDiscount = $cart->campaign_discount;
            $subtotal = round($cart->service_cost * $cart['quantity'], 2);
            $applicableDiscount = ($campaignDiscount >= $basicDiscount) ? $campaignDiscount : $basicDiscount;
            $effectiveTaxPercent = providerEffectiveTaxPercent($cart->provider, (float) ($service['tax'] ?? 0));
            $tax = round((($subtotal - $applicableDiscount) * $effectiveTaxPercent) / 100, 2);

            //updated values
            $cart->tax_amount = $tax;
            $cart->total_cost = round($subtotal - $applicableDiscount + $tax, 2);
            $cart->coupon_discount = 0;
            $cart->coupon_code = null;
            $cart->coupon_id = 0;
            $cart->save();
        }

        return response()->json(response_formatter(DEFAULT_UPDATE_200), 200);
    }

}

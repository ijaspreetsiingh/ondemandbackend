<?php

namespace Modules\ServiceManagement\Http\Controllers\Api\V1\Customer;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Modules\BookingModule\Entities\Booking;
use Modules\CategoryManagement\Entities\Category;
use Modules\CustomerModule\Traits\CustomerSearchTrait;
use Modules\ReviewModule\Entities\Review;
use Modules\ServiceManagement\Entities\FavoriteService;
use Modules\ServiceManagement\Entities\RecentSearch;
use Modules\ServiceManagement\Entities\RecentView;
use Modules\ServiceManagement\Entities\Service;
use Modules\ServiceManagement\Entities\ServiceRequest;
use Modules\ServiceManagement\Entities\Variation;
use Modules\ServiceManagement\Traits\VisitedServiceTrait;
use Modules\ZoneManagement\Entities\Zone;
use Stevebauman\Location\Facades\Location;

class ServiceController extends Controller
{
    use VisitedServiceTrait;
    use CustomerSearchTrait;

    private Service $service;
    private Review $review;
    private RecentView $recentView;
    private RecentSearch $recentSearch;
    private Booking $booking;
    private Zone $zone;
    private Category $category;

    private  FavoriteService $favoriteService;

    private bool $is_customer_logged_in;
    private mixed $customer_user_id;

    public function __construct(Service $service, Review $review, RecentView $recentView, RecentSearch $recentSearch, Booking $booking, Zone $zone, FavoriteService $favoriteService, Request $request, Category $category)
    {
        $this->service = $service;
        $this->review = $review;
        $this->recentView = $recentView;
        $this->recentSearch = $recentSearch;
        $this->booking = $booking;
        $this->zone = $zone;
        $this->favoriteService = $favoriteService;
        $this->category = $category;

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

        $services = $this->service
            ->with(['category.zonesBasicInfo', 'variations', 'service_discount', 'category.category_discount'])
            ->where(function ($query) {
                $query->where(function ($query) {
                    $query->whereDoesntHave('service_discount')
                        ->orWhereHas('service_discount');
                })->orWhere(function ($query) {
                    $query->whereDoesntHave('category.category_discount')
                        ->orWhereHas('category.category_discount');
                });
            })
            ->active()
            ->visibleInCurrentZone()
            ->latest()
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])
            ->withPath('');

        $this->attachFavoriteStatus($services);

        return response()->json(response_formatter(DEFAULT_200, self::variationMapper($services)), 200);
    }

    public function search(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000',
            'string' => 'nullable',
            'sort_by' => 'nullable|in:a_to_z,z_to_a,high_to_low,low_to_high',
            'sort_by_type' => 'nullable|in:default,top_rated,most_loved,popular,newest,recommended,trending',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $decodedString = trim((string) $request->input('string', ''));
        $tokenGroups = $this->searchTokenGroups($decodedString);
        $zoneId = Config::get('zone_id');
        $globalZoneId = global_zone_id();

        $authUser = auth('api')->user();
        if ($authUser) {
            $this->recentSearch->Create(['user_id' => $authUser->id, 'keyword' => $decodedString]);
        }

        $servicesQuery = $this->service
            ->select('services.*')
            ->selectRaw('CAST(COALESCE(
                (SELECT MIN(variations.price) FROM variations WHERE variations.service_id = services.id AND variations.price > 0 AND variations.zone_id = ?),
                (SELECT MIN(variations.price) FROM variations WHERE variations.service_id = services.id AND variations.price > 0 AND variations.zone_id = ?)
            ) AS DECIMAL(24, 2)) as service_filter_min_price', [$zoneId, $globalZoneId ?: $zoneId])
            ->with(['category.zonesBasicInfo', 'variations', 'tags', 'faqs', 'favorites', 'service_discount', 'category.category_discount'])
            ->withCount('favorites', 'bookings')
            ->active()
            ->visibleInCurrentZone()
            ->where(function ($query) use ($tokenGroups, $zoneId, $globalZoneId) {
                $priceZoneIds = array_values(array_filter(array_unique([$zoneId, $globalZoneId])));
                foreach ($tokenGroups as $alternatives) {
                    $query->where(function ($tokenQuery) use ($alternatives, $priceZoneIds) {
                        foreach ($alternatives as $term) {
                            $tokenQuery->orWhere(function ($match) use ($term, $priceZoneIds) {
                                $match->where('name', 'LIKE', "%{$term}%")
                                    ->orWhere('short_description', 'LIKE', "%{$term}%")
                                    ->orWhere('description', 'LIKE', "%{$term}%")
                                    ->orWhereHas('variations', function ($variationQuery) use ($term, $priceZoneIds) {
                                        $variationQuery->withoutGlobalScope('zone_wise_data')
                                            ->when(!empty($priceZoneIds), fn ($q) => $q->whereIn('zone_id', $priceZoneIds))
                                            ->where('variant', 'LIKE', "%{$term}%");
                                    })
                                    ->orWhereHas('category', fn ($category) => $category->where('name', 'LIKE', "%{$term}%"))
                                    ->orWhereHas('subCategory', fn ($category) => $category->where('name', 'LIKE', "%{$term}%"))
                                    ->orWhereHas('tags', fn ($tag) => $tag->where('tag', 'LIKE', "%{$term}%"))
                                    ->orWhereHas('faqs', fn ($faq) => $faq->where('question', 'LIKE', "%{$term}%"))
                                    ->orWhereHas('translations', function ($translationQuery) use ($term) {
                                        $translationQuery->whereIn('key', ['name', 'short_description', 'description'])
                                            ->where('value', 'LIKE', "%{$term}%");
                                    });
                            });
                        }
                    });
                }
            })
            ->when(!is_null($request['rating']), function ($query) use ($request){
                return $query->where('avg_rating', '>=', $request['rating']);
            })
            ->when(isset($request['category_ids']) && is_array($request['category_ids']), function ($query) use ($request) {
                return $query->whereIn('category_id', $request['category_ids']);
            })
            ->when(isset($request['sort_by_type']) && !is_null($request['sort_by_type']), function ($query) use ($request) {
                return $query->when($request['sort_by_type'] == 'top_rated', function ($query) {
                    return $query->orderBy('avg_rating', 'DESC');
                })
                    ->when($request['sort_by_type'] == 'most_loved', function ($query) {
                        return $query->orderBy('order_count', 'DESC')
                            ->orderByDesc('favorites_count');
                    })
                    ->when($request['sort_by_type'] == 'popular', function ($query) {
                        return $query->orderByDesc('bookings_count');
                    })
                    ->when($request['sort_by_type'] == 'newest', function ($query) {
                        return $query->orderBy('created_at', 'DESC');
                    })
                    ->when($request['sort_by_type'] == 'recommended', function ($query) {
                        return $query->when($this->is_customer_logged_in, function ($query) {
                            $categoryIds = $this->booking->where('customer_id', auth('api')->user()->id)->get()->pluck('category_id');
                            if ($categoryIds->count() > 0) {
                                $query->whereHas('category', function ($query) use ($categoryIds) {
                                    $query->whereIn('category_id', $categoryIds);
                                });
                            } else {
                                $query->inRandomOrder();}
                        })->when(!$this->is_customer_logged_in, function ($query) {
                            $query->inRandomOrder();
                        });
                    })
                    ->when($request['sort_by_type'] == 'trending', function ($query) {
                        return $query->when($this->booking->count() > 0, function ($query){
                            $query->whereHas('bookings', function ($query) {
                                $query->where('created_at', '>', now()->subDays(30)->endOfDay());
                            })->orderBy('bookings_count', 'desc');
                        });
                    });
            })
            ->when(isset($request['sort_by']) && $request['sort_by'] != null, function ($query) use ($request) {
                switch ($request['sort_by']) {
                    case 'a_to_z':
                        $query->orderBy('name', 'asc');
                        break;
                    case 'z_to_a':
                        $query->orderBy('name', 'desc');
                        break;
                    case 'high_to_low':
                        $query->orderBy('service_filter_min_price', 'desc');
                        break;
                    case 'low_to_high':
                        $query->orderBy('service_filter_min_price', 'asc');
                        break;
                    default:
                        $query->orderBy('created_at', 'desc');
                        break;
                }
            })
            ->when($request['min_price'] !== null && $request['max_price'] !== null && $request['max_price'] > 0, function ($query) use ($request) {
                $query->havingRaw('service_filter_min_price >= ? AND service_filter_min_price <= ?', [$request['min_price'], $request['max_price']]);
            })
            ->when(is_null($request['sort_by_type']) && is_null($request['sort_by']), function ($query) use ($decodedString){
                // SECURITY: user search string ko kabhi raw SQL me mat interpolate karo —
                // pehle 'name = $decodedString' par SQL injection tha; ab ? bindings.
                $query->orderByRaw("
                    CASE
                        WHEN name = ? THEN 0
                        WHEN name LIKE ? THEN 1
                        WHEN name LIKE ? THEN 2
                        WHEN name LIKE ? THEN 3
                        ELSE 4
                    END
                ", [
                    $decodedString,
                    "$decodedString%",
                    "%$decodedString%",
                    "%$decodedString",
                ]);
            });

        $variationPriceFilter = $servicesQuery->get();

        if ($authUser) {
            $recentSearch = RecentSearch::where('keyword', $decodedString)->oldest()->first();
            $this->Searched_data_log($authUser->id, 'search', $recentSearch->id, count($variationPriceFilter));
        }

        $price = [];
        foreach ($variationPriceFilter as $key => $service) {
            $minPrice = null;
            $minPriceVariation = null;
            foreach (effective_zone_variations($service, $zoneId) as $variation) {
                if ($minPrice === null || $variation->price < $minPrice) {
                    $minPrice = $variation->price;
                    $minPriceVariation = $variation;
                }
            }
            if ($minPriceVariation !== null) {
                $price[] = $minPriceVariation->price;
            }
        }

        $filterMinPrice = count($price) > 0 ? min($price) : 0;
        $filterMaxPrice = count($price) > 0 ? max($price) : 0;

        $initialMinPrice = Variation::min('price');
        $initialMaxPrice = Variation::max('price');

        $services = $servicesQuery->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        $this->attachFavoriteStatus($services);
        foreach ($services as $service){
            unset($service->tags, $service->faqs, $service->favorites);
        }

        return response()->json(response_formatter(DEFAULT_200, [
            'filter_min_price' => $filterMinPrice == $filterMaxPrice ? 0 : $filterMinPrice,
            'filter_max_price' => $filterMaxPrice,
            'initial_min_price' => $initialMinPrice == $initialMaxPrice ? 0 : $initialMinPrice,
            'initial_max_price' => $initialMaxPrice,
            'services' => self::variationMapper($services)
        ]), 200);
    }

    /**
     * Expand common Hinglish service words while still searching the original
     * token and the localized service/category text stored in the database.
     */
    private function searchTokenGroups(string $query): array
    {
        $tokens = preg_split('/[^\\p{L}\\p{N}]+/u', strtolower($query), -1, PREG_SPLIT_NO_EMPTY) ?: [];
        $tokens = array_slice($tokens, 0, 6);
        $stopWords = [
            'a', 'an', 'the', 'please', 'i', 'me', 'my', 'need', 'want', 'looking', 'for', 'find', 'book', 'service',
            'hai', 'hain', 'ho', 'hu', 'h', 'mujhe', 'chahiye', 'karna', 'karni', 'karwana', 'karvao', 'karo', 'krna', 'krwao',
            'ka', 'ki', 'ke', 'ko', 'kaise', 'wala', 'wali', 'wale', 'mera', 'meri', 'mere', 'kar', 'do', 'mein', 'me', 'seva', 'sevaen', 'fix', 'repair', 'ठीक', 'करो', 'सेवा', 'सेवाएं', 'सर्विस', 'से',
            'मुझे', 'चाहिए', 'करना', 'करनी', 'करवाना', 'है', 'हैं', 'करो', 'कृपया', 'का', 'की', 'के', 'लिए', 'मेरे', 'मेरी', 'मेरा', 'में',
        ];
        $aliases = [
            'ghar' => ['home', 'house'], 'house' => ['home', 'ghar'], 'home' => ['house', 'ghar'],
            'safai' => ['clean', 'cleaning', 'housekeeping'], 'safaai' => ['clean', 'cleaning', 'housekeeping'],
            'safayi' => ['clean', 'cleaning', 'housekeeping'], 'saaf' => ['clean', 'cleaning'], 'jhadu' => ['cleaning', 'housekeeping'],
            'jhaadu' => ['cleaning', 'housekeeping'], 'pocha' => ['mopping', 'cleaning'], 'bartan' => ['dishwashing', 'cleaning'],
            'bathroom' => ['washroom', 'toilet'], 'washroom' => ['bathroom', 'toilet'], 'toilet' => ['bathroom', 'plumbing'],
            'paani' => ['water', 'plumbing', 'pipe'], 'pani' => ['water', 'plumbing', 'pipe'], 'nal' => ['tap', 'plumbing', 'pipe'],
            'tap' => ['nal', 'plumbing'], 'pipe' => ['plumbing', 'leak', 'leakage'], 'leak' => ['leakage', 'plumbing'],
            'leakage' => ['leak', 'plumbing'], 'plumber' => ['plumbing', 'pipe', 'leak'], 'plumbing' => ['plumber', 'pipe', 'leak'],
            'bijli' => ['electricity', 'electrical', 'electrician', 'wiring'], 'electrician' => ['electrical', 'electric', 'wiring', 'bijli'],
            'pankha' => ['fan', 'electrical', 'electrician'], 'fan' => ['pankha', 'electrical', 'electrician'],
            'light' => ['lighting', 'electrical', 'electrician'], 'wiring' => ['electrical', 'electrician', 'bijli'],
            'ac' => ['air conditioner', 'air conditioning', 'cooling'], 'cooler' => ['cooling', 'air conditioner'],
            'thanda' => ['cooling', 'air conditioner', 'ac'], 'badhai' => ['carpenter', 'carpentry', 'furniture', 'wood'],
            'lakdi' => ['wood', 'carpenter', 'carpentry'], 'darwaza' => ['door', 'carpenter', 'carpentry'],
            'furniture' => ['carpenter', 'carpentry', 'wood'], 'carpenter' => ['carpentry', 'furniture', 'wood'],
            'keede' => ['pest', 'insect', 'cockroach', 'pest control'], 'cockroach' => ['pest', 'pest control', 'insect'],
            'tilchatta' => ['cockroach', 'pest', 'pest control'], 'machhar' => ['mosquito', 'pest', 'pest control'],
            'mosquito' => ['machhar', 'pest', 'pest control'], 'deemak' => ['termite', 'pest', 'pest control'],
            'termite' => ['deemak', 'pest', 'pest control'], 'chuha' => ['rat', 'rodent', 'pest control'],
            'baal' => ['hair', 'haircut', 'salon', 'beauty'], 'haircut' => ['hair', 'salon', 'barber'],
            'naai' => ['barber', 'haircut', 'salon'], 'barber' => ['naai', 'haircut', 'salon'],
            'makeup' => ['beauty', 'salon'], 'facial' => ['beauty', 'salon'],
            'kapde' => ['clothes', 'laundry', 'washing', 'iron'], 'dhulai' => ['laundry', 'washing', 'wash'],
            'dhona' => ['washing', 'laundry', 'wash'], 'press' => ['ironing', 'laundry', 'clothes'],
            'istri' => ['ironing', 'laundry', 'clothes'], 'fridge' => ['refrigerator', 'appliance'],
            'refrigerator' => ['fridge', 'appliance'], 'geyser' => ['water heater', 'appliance'],
            'rangai' => ['painting', 'paint', 'painter'], 'rang' => ['painting', 'paint', 'painter'],
            'deewar' => ['wall', 'painting', 'paint'], 'painter' => ['painting', 'paint', 'rangai'],
            'maalish' => ['massage', 'therapy'], 'gaadi' => ['car', 'vehicle', 'washing', 'cleaning'],
            'car' => ['vehicle', 'automobile'], 'bike' => ['motorcycle', 'vehicle'],
            'घर' => ['home', 'house'], 'होम' => ['home', 'house'], 'सफाई' => ['clean', 'cleaning', 'housekeeping'], 'साफ' => ['clean', 'cleaning'], 'क्लीनिंग' => ['cleaning', 'clean'], 'झाड़ू' => ['cleaning', 'housekeeping'],
            'पोछा' => ['mopping', 'cleaning'], 'बर्तन' => ['dishwashing', 'cleaning'],
            'नल' => ['tap', 'plumbing', 'pipe'], 'पानी' => ['water', 'plumbing', 'pipe'],
            'प्लंबर' => ['plumber', 'plumbing', 'pipe'], 'प्लंबिंग' => ['plumber', 'plumbing', 'pipe'], 'बिजली' => ['electrical', 'electrician', 'wiring'], 'इलेक्ट्रिशियन' => ['electrician', 'electrical', 'wiring'], 'इलेक्ट्रीशियन' => ['electrician', 'electrical', 'wiring'],
            'पंखा' => ['fan', 'electrical', 'electrician'], 'एसी' => ['ac', 'air conditioner', 'cooling'],
            'कूलर' => ['cooler', 'cooling', 'air conditioner'], 'बढ़ई' => ['carpenter', 'carpentry', 'wood'], 'कारपेंटर' => ['carpenter', 'carpentry', 'wood'],
            'लकड़ी' => ['wood', 'carpenter', 'carpentry'], 'दरवाजा' => ['door', 'carpenter', 'carpentry'],
            'कीड़े' => ['pest', 'insect', 'cockroach', 'pest control'], 'तिलचट्टा' => ['cockroach', 'pest', 'pest control'],
            'मच्छर' => ['mosquito', 'pest', 'pest control'], 'दीमक' => ['termite', 'pest', 'pest control'],
            'बाल' => ['hair', 'haircut', 'salon', 'beauty'], 'नाई' => ['barber', 'haircut', 'salon'],
            'कपड़े' => ['clothes', 'laundry', 'washing'], 'लॉन्ड्री' => ['laundry', 'washing', 'clothes'], 'वॉशिंग' => ['washing', 'laundry', 'clothes'], 'धुलाई' => ['laundry', 'washing', 'wash'],
            'फ्रिज' => ['fridge', 'refrigerator', 'appliance'], 'गीजर' => ['geyser', 'water heater', 'appliance'],
            'रंगाई' => ['painting', 'paint', 'painter'], 'पेंटिंग' => ['painting', 'paint', 'painter'], 'मालिश' => ['massage', 'therapy'],
        ];

        $groups = [];
        foreach ($tokens as $token) {
            if (in_array($token, $stopWords, true)) {
                continue;
            }
            $groups[] = array_slice(array_values(array_unique(array_merge([$token], $aliases[$token] ?? []))), 0, 4);
        }

        if (empty($groups) && !empty($tokens)) {
            $groups = array_map(fn ($token) => [$token], array_values(array_unique($tokens)));
        }

        return empty($groups) ? [['__search_no_tokens__']] : $groups;
    }
    public function searchSuggestions(Request $request)
    {
        $decodedString = trim((string) $request->input('string', ''));
        if ($decodedString === '') {
            return response()->json(response_formatter(DEFAULT_200, []), 200);
        }
        $tokenGroups = $this->searchTokenGroups($decodedString);

        $bindings = [
            $decodedString,
            "$decodedString%",
            "%$decodedString%",
            "%$decodedString"
        ];

        $searchQuery = $this->service->active()->visibleInCurrentZone()
            ->where(function ($query) use ($tokenGroups) {
                foreach ($tokenGroups as $alternatives) {
                    $query->where(function ($tokenQuery) use ($alternatives) {
                        foreach ($alternatives as $term) {
                            $tokenQuery->orWhere(function ($match) use ($term) {
                                $match->where('name', 'LIKE', "%{$term}%")
                                    ->orWhereHas('category', fn ($category) => $category->where('name', 'LIKE', "%{$term}%"))
                                    ->orWhereHas('subCategory', fn ($category) => $category->where('name', 'LIKE', "%{$term}%"))
                                    ->orWhereHas('tags', fn ($tag) => $tag->where('tag', 'LIKE', "%{$term}%"))
                                    ->orWhereHas('translations', function ($translationQuery) use ($term) {
                                        $translationQuery->whereIn('key', ['name', 'short_description', 'description'])
                                            ->where('value', 'LIKE', "%{$term}%");
                                    });
                            });
                        }
                    });
                }
            })
            ->orderByRaw("
                CASE
                    WHEN name = ? THEN 0
                    WHEN name LIKE ? THEN 1
                    WHEN name LIKE ? THEN 2
                    WHEN name LIKE ? THEN 3
                    ELSE 4
                END
            ", $bindings);

        $results = $searchQuery->take(100)->get(['name'])->pluck('name')->unique();

        $authUser = auth('api')->user();
        // W4.25: N+1 fix — har keyword ke liye alag exists() query ki jagah ek query
        $searchedKeywords = collect();
        if ($authUser) {
            $searchedKeywords = $this->recentSearch
                ->whereIn('keyword', $results->all())
                ->pluck('keyword');
        }
        $services = $results->map(function ($serviceName) use ($searchedKeywords) {
            $recentSearched = $searchedKeywords->contains($serviceName) ? 1 : 0;
            return [
                'name' => $serviceName,
                'is_searched' => $recentSearched
            ];
        });

        $servicesArray = $services->values()->toArray();
        return response()->json(response_formatter(DEFAULT_200, $servicesArray), 200);
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function popular(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $servicesQuery = $this->service->with(['category.zonesBasicInfo', 'variations', 'service_discount', 'category.category_discount'])
            ->where(function ($query) {
                $query->where(function ($query) {
                    $query->whereDoesntHave('service_discount')
                        ->orWhereHas('service_discount');
                })->orWhere(function ($query) {
                    $query->whereDoesntHave('category.category_discount')
                        ->orWhereHas('category.category_discount');
                });
            })
            ->withCount('bookings')
            ->orderBy('bookings_count', 'desc')
            ->active()
            ->visibleInCurrentZone();

        if ($this->booking->count() > 0) {
            $servicesQuery->has('bookings');
        }

        $services = $servicesQuery->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        $this->attachFavoriteStatus($services);

        return response()->json(response_formatter(DEFAULT_200, self::variationMapper($services)), 200);
    }

    /**
     * Display a listing of the resource.
     *  #   if not authenticated > Random Services
     *  #   if authenticated
     *      ##  has booking > Services of booked category
     *      ##  no booking > Random services
     * @param Request $request
     * @return JsonResponse
     */
    public function recommended(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $servicesQuery = $this->service->with([
            'category.zonesBasicInfo',
            'variations',
            'service_discount',
            'category.category_discount'
        ])
        ->where(function ($query) {
            $query->whereDoesntHave('service_discount')
                ->orWhereHas('service_discount');
        })
        ->where(function ($query) {
            $query->whereDoesntHave('category.category_discount')
                ->orWhereHas('category.category_discount');
        })
        ->visibleInCurrentZone();

        if (auth('api')->user()) {
            $user = auth('api')->user();
            $categoryIds = $this->booking->where('customer_id', $user->id)
                ->pluck('category_id');

            if ($categoryIds->isNotEmpty()) {
                $servicesQuery->whereHas('category', function ($query) use ($categoryIds) {
                    $query->whereIn('category_id', $categoryIds);
                });
            }

            $services = $servicesQuery->active()
                ->latest()
                ->paginate($request['limit'], ['*'], 'offset', $request['offset'])
                ->withPath('');

            $this->attachFavoriteStatus($services, $user->id);
        } else {
            $services = $servicesQuery->active()
                ->inRandomOrder()
                ->latest()
                ->paginate($request['limit'], ['*'], 'offset', $request['offset'])
                ->withPath('');

            $this->attachFavoriteStatus($services);
        }

        return response()->json(response_formatter(DEFAULT_200, self::variationMapper($services)), 200);
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function searchRecommended(Request $request): JsonResponse
    {
        $services = $this->service->select('id', 'name')
            ->active()
            ->visibleInCurrentZone()
            ->inRandomOrder()
            ->take(5)->get();

        $this->attachFavoriteStatus($services);

        return response()->json(response_formatter(DEFAULT_200, self::variationMapper($services)), 200);
    }

    /**
     * Trending products (Last 30days order based)
     * @param Request $request
     * @return JsonResponse
     */
    public function trending(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $servicesQuery = $this->service
            ->with(['category.zonesBasicInfo', 'variations', 'service_discount', 'category.category_discount'])
            ->where(function ($query) {
                $query->where(function ($query) {
                    $query->whereDoesntHave('service_discount')
                        ->orWhereHas('service_discount');
                })->orWhere(function ($query) {
                    $query->whereDoesntHave('category.category_discount')
                        ->orWhereHas('category.category_discount');
                });
            })
            ->withCount(['bookings' => function ($query) {
                $query->where('created_at', '>', now()->subDays(30)->endOfDay());
            }])
            ->orderBy('bookings_count', 'desc')
            ->active()
            ->visibleInCurrentZone();

        if ($this->booking->count() > 0) {
            $servicesQuery->whereHas('bookings', function ($query) {
                $query->where('created_at', '>', now()->subDays(30)->endOfDay());
            });
        }

        $services = $servicesQuery->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        $this->attachFavoriteStatus($services);

        return response()->json(response_formatter(DEFAULT_200, self::variationMapper($services)), 200);
    }

    /**
     * Recently viewed by customer (service view based)
     * @param Request $request
     * @return JsonResponse
     */
    public function recentlyViewed(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $serviceIds = $this->recentView
            ->where('user_id', $request->user()->id)
            ->select(
                DB::raw('count(total_service_view) as total_service_view'),
                DB::raw('service_id as service_id')
            )
            ->groupBy('total_service_view', 'service_id')
            ->pluck('service_id')
            ->toArray();

        $services = $this->service->with(['category.zonesBasicInfo', 'variations', 'service_discount', 'category.category_discount'])
            ->whereIn('id', $serviceIds)
            ->where(function ($query) {
                $query->where(function ($query) {
                    $query->whereDoesntHave('service_discount')
                        ->orWhereHas('service_discount');
                })->orWhere(function ($query) {
                    $query->whereDoesntHave('category.category_discount')
                        ->orWhereHas('category.category_discount');
                });
            })
            ->active()
            ->visibleInCurrentZone()
            ->orderBy('avg_rating', 'DESC')
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])
            ->withPath('');

        $this->attachFavoriteStatus($services);

        return response()->json(response_formatter(DEFAULT_200, self::variationMapper($services)), 200);
    }

    /**
     * Recently searched keywords by customer
     * @param Request $request
     * @return JsonResponse
     */
    public function recentlySearchedKeywords(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $searchedKeywords = $this->recentSearch
            ->where('user_id', $request->user()->id)
            ->select('id', 'keyword')
            ->latest()
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        if (count($searchedKeywords) > 0) {
            return response()->json(response_formatter(DEFAULT_200, $searchedKeywords), 200);
        }

        return response()->json(response_formatter(DEFAULT_404), 404);
    }

    /**
     * Remove searched keywords by customer
     * @param Request $request
     * @return JsonResponse
     */
    public function removeSearchedKeywords(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'id' => 'array',
            'id.*' => 'uuid',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $this->recentSearch
            ->where('user_id', $request->user()->id)
            ->when($request->has('id'), function ($query) use ($request) {
                $query->whereIn('id', $request->id);
            })
            ->delete();

        return response()->json(response_formatter(DEFAULT_DELETE_200), 200);
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function offers(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if (!session()->has('location')) {
            $data = Location::get($request->ip());
            $location = [
                'lat' => $data ? $data->latitude : '23.757989',
                'lng' => $data ? $data->longitude : '90.360587'
            ];
            session()->put('location', $location);
        }

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $services = $this->service
            ->with(['category.zonesBasicInfo', 'variations', 'service_discount', 'category.category_discount'])
            ->where(function ($query) {
                $query->whereHas('service_discount')
                    ->orWhereHas('category.category_discount');
            })
            ->active()
            ->visibleInCurrentZone()
            ->orderBy('avg_rating', 'DESC')
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        $this->attachFavoriteStatus($services);

        return response()->json(response_formatter(DEFAULT_200, self::variationMapper($services)), 200);
    }

    /**
     * W4.25: N+1 fix — purane code me har service ke liye alag
     * favoriteService->exists() query chalti thi (page size = queries).
     * Ab page ke saare favorite IDs ek hi query me aate hain.
     */
    private function attachFavoriteStatus($services, ?string $userId = null): void
    {
        $userId ??= $this->customer_user_id;
        $favoriteIds = collect();
        if ($userId) {
            $serviceIds = collect($services->pluck('id')->all())->filter()->values()->all();
            if (!empty($serviceIds)) {
                $favoriteIds = $this->favoriteService
                    ->where('customer_user_id', $userId)
                    ->whereIn('service_id', $serviceIds)
                    ->pluck('service_id');
            }
        }
        foreach ($services as $service) {
            $service['is_favorite'] = $favoriteIds->contains($service->id) ? 1 : 0;
        }
    }

    private function variationMapper($services)
    {
        $services->map(function ($service) {
            $service['variations_app_format'] = self::variationsAppFormat($service);
            return $service;
        });
        return $services;
    }

    private function variationsAppFormat($service): array
    {
        $formatting = [];
        $zoneId = Config::get('zone_id');

        $formatting['zone_id'] = $zoneId;

        // Current zone ka price priority. Jis variant ka current zone me price
        // nahi hai, wo "All over the World" (catch-all) zone se fill hota hai.
        // Kisi doosri city zone ka price kabhi mix nahi hota.
        $variations = effective_zone_variations($service, $zoneId);
        $firstVariation = $variations->first();
        $formatting['default_price'] = $firstVariation ? $firstVariation->price : 0;

        // Fallback: agar variation price 0 hai, toh service ka min_bidding_price lein
        if ($formatting['default_price'] == 0 && isset($service->min_bidding_price) && $service->min_bidding_price > 0) {
            $formatting['default_price'] = $service->min_bidding_price;
        }

        foreach ($variations as $data) {
            $formatting['zone_wise_variations'][] = [
                'variant_key' => $data['variant_key'],
                'variant_name' => $data['variant'],
                'price' => $data['price']
            ];
        }
        return $formatting;
    }

    /**
     * Show the specified resource.
     * @param Request $request
     * @param string $id
     * @return JsonResponse
     */
    public function show(Request $request, string $slug): JsonResponse
    {
        $service = $this->service->where('slug', $slug)
            ->with(['category.children', 'variations', 'faqs' => function ($query) {
                return $query->where('is_active', 1);
            }])
            ->ofStatus(1)
            ->visibleInCurrentZone()
            ->first();

        if (isset($service)) {
            if ($request->has('attribute') && $request->attribute == 'service' && auth('api')->user()) {
                $this->Searched_data_log(auth('api')->user()->id, 'service', $service->id, null);
            }

            if (auth('api')->user()) {
                $this->visited_service_update(auth('api')->user()->id, $service->id);

                //search log volume update
                if ($request->has('attribute') && $request->attribute != 'service') {
                    $this->search_log_volume_update(auth('api')->user()->id, $service->id);
                }
            }

            $authUser = auth('api')->user();
            if ($authUser) {
                $recentView = $this->recentView->firstOrNew(['service_id' => $service->id, 'user_id' => $authUser->id]);
                $recentView->total_service_view += 1;
                $recentView->save();
            }

            $service['variations_app_format'] = self::variationsAppFormat($service);
            return response()->json(response_formatter(DEFAULT_200, $service), 200);
        }

        return response()->json(response_formatter(DEFAULT_204), 200);
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @param string $serviceId
     * @return JsonResponse
     */
    public function review(Request $request, string $serviceId): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $reviews = $this->review->with(['provider', 'customer','reviewReply','serviceman.user'])->where('service_id', $serviceId)->ofStatus(1)->latest()
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        $ratingGroupCount = DB::table('reviews')->where('service_id', $serviceId)
            ->where('is_active', 1)
            ->select('review_rating', DB::raw('count(review_comment) as total_comment'), DB::raw('count(*) as total'))
            ->groupBy('review_rating')
            ->get();

        $totalRating = 0;
        $ratingCount = 0;
        $reviewCount = 0;

        foreach ($ratingGroupCount as $count) {
            $totalRating += round($count->review_rating * $count->total, 2);
            $ratingCount += $count->total;
            $reviewCount += $count->total_comment;
        }

        $ratingInfo = [
            'rating_count' => $ratingCount,
            'review_count' => $reviewCount,
            'average_rating' => round(divnum($totalRating, $ratingCount), 2),
            'rating_group_count' => $ratingGroupCount,
        ];

        return response()->json(response_formatter(DEFAULT_200, ['reviews' => $reviews, 'rating' => $ratingInfo]), 200);
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @param string $subCategoryId
     * @return JsonResponse
     */
    public function servicesBySubcategory(Request $request, string $slug): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $subCategoryId = $this->category->withoutGlobalScopes()->where(['slug' => $slug])->ofType('sub')->first()?->id ?? null;

        if ($subCategoryId == null) {
            return response()->json(response_formatter(DEFAULT_404, null, [['code' => 'sub-category', 'message' => translate('Sub Category not found')]]), 404);
        }

        $servicesQuery = $this->service
            ->with(['category.zonesBasicInfo', 'variations', 'service_discount', 'category.category_discount'])
            ->where('sub_category_id', $subCategoryId)
            ->where('is_active', 1)
            ->where(function ($query) {
                $query->whereDoesntHave('service_discount')
                    ->orWhereHas('service_discount')
                    ->orWhere(function ($query) {
                        $query->whereDoesntHave('category.category_discount')
                            ->orWhereHas('category.category_discount');
                    });
            })
            ->visibleInCurrentZone()
            ->latest();

        $services = $servicesQuery
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])
            ->withPath('');

        $this->attachFavoriteStatus($services);

        if (count($services) > 0) {
            $authUser = auth('api')->user();
            if ($authUser) {
                $recentView = $this->recentView->firstOrNew(['sub_category_id' => $subCategoryId, 'user_id' => $authUser->id]);
                $recentView->total_sub_category_view += 1;
                $recentView->save();
            }

            return response()->json(response_formatter(DEFAULT_200, self::variationMapper($services)), 200);
        }

        return response()->json(response_formatter(DEFAULT_204), 200);
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function makeRequest(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'category_id' => 'nullable|uuid',
            'service_name' => 'required|max:255',
            'service_description' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        ServiceRequest::create([
            'category_id' => strtolower($request['category_id']) == 'null' || $request['category_id'] == '' ? null : $request['category_id'],
            'service_name' => $request['service_name'],
            'service_description' => $request['service_description'],
            'status' => 'pending',
            'user_id' => $request->user()->id,
        ]);

        return response()->json(response_formatter(DEFAULT_STORE_200), 200);
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function requestList(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $requests = ServiceRequest::with(['category'])
            ->where('user_id', $request->user()->id)
            ->latest()
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        if ($requests->count() > 0) {
            return response()->json(response_formatter(DEFAULT_200, $requests), 200);
        }
        return response()->json(response_formatter(DEFAULT_204, $requests), 200);
    }

    public function serviceAreaAvailability(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $zones = $this->zone
            ->where('is_active', 1)
            ->latest()->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        foreach ($zones as $key=>$zone) {
            $object = json_decode($zone->coordinates[0]->toJson(),true)['coordinates'];
            $data = [];
            foreach ($object as $coordinate) {
                $data[] = (object)['latitude' => $coordinate[1], 'longitude' => $coordinate[0]]; //unusual case for lat long
            }

            $formatted_coordinates = $data;
            $zone['formatted_coordinates'] = $formatted_coordinates;
            unset($zones[$key]['coordinates']);
            unset($zones[$key]['is_active']);
        }

        return response()->json(response_formatter(DEFAULT_200, $zones), 200);
    }
}

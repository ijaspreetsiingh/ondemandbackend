@extends('adminmodule::layouts.master')

@section('title',translate('add_new_coupon'))

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-wrap mb-3">
                        <h2 class="page-title">{{translate('add_new_coupon')}}</h2>
                    </div>
                    <div class="card">
                        <div class="card-body p-30">
                            <form action="{{route('admin.coupon.store')}}" method="POST">
                                @csrf
                                @php($language= Modules\BusinessSettingsModule\Entities\BusinessSettings::where('key_name','system_language')->first())
                                @php($default_lang = str_replace('_', '-', app()->getLocale()))
                                @if($language)
                                    <ul class="nav nav-tabs nav__tabs_scrolling mb-4">
                                        <li class="nav-item">
                                            <a class="nav-link lang_link active"
                                               href="#"
                                               id="default-link">{{translate('default')}}</a>
                                        </li>
                                        @foreach ($language?->live_values as $lang)
                                            <li class="nav-item">
                                                <a class="nav-link lang_link"
                                                   href="#"
                                                   id="{{ $lang['code'] }}-link">{{ get_language_name($lang['code']) }}</a>
                                            </li>
                                        @endforeach
                                    </ul>
                                @endif
                                <div class="discount-type">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="mb-30">
                                                <select class="js-select theme-input-style w-100" name="coupon_type"
                                                        id="coupon-type">
                                                    <option selected
                                                            disabled>{{translate('select_coupon_type')}}</option>
                                                    @foreach(COUPON_TYPES as $index=>$coupon_type)
                                                        <option value="{{$index}}">{{$coupon_type}}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="text" class="form-control" name="coupon_code"
                                                           placeholder="{{translate('coupon_code')}}" required>
                                                    <label>{{translate('coupon_code')}} *</label>
                                                    <span class="material-icons">subtitles</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 d-none" id="customer-select__div">
                                            <div class="mb-30">
                                                <label class="mb-2">{{ translate('Select Customers') }}</label>
                                                <select class="js-select theme-input-style w-100" id="customer-select"
                                                        name="customer_user_ids[]" multiple
                                                        data-placeholder="{{ translate('Select customer') }}">
                                                    <option value="all">{{translate('Select All')}}</option>
                                                    @foreach($customers as $key=>$customer)
                                                        <option
                                                            value="{{$customer->id}}">{{$customer->first_name .' '. $customer->last_name}}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">{{translate('discount_type')}}</div>
                                    <div class="d-flex flex-wrap align-items-center gap-4 mb-30">
                                        <div class="custom-radio">
                                            <input type="radio" id="category" name="discount_type" value="category"
                                                   checked>
                                            <label for="category">{{translate('category_wise')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="service" name="discount_type" value="service">
                                            <label for="service">{{translate('service_wise')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="mixed" name="discount_type" value="mixed">
                                            <label for="mixed">{{translate('mixed')}}</label>
                                        </div>
                                    </div>
                                    @if ($language)
                                        <div class="form-floating form-floating__icon mb-30 lang-form" id="default-form">
                                            <input type="text" name="discount_title[]" class="form-control"
                                                   placeholder="{{translate('discount_title')}}" required>
                                            <label>{{translate('discount_title')}} ({{ translate('default') }}) *</label>
                                            <span class="material-icons">title</span>
                                        </div>
                                        <input type="hidden" name="lang[]" value="default">
                                        @foreach ($language?->live_values as $lang)
                                            <div class="form-floating form-floating__icon mb-30 d-none lang-form" id="{{$lang['code']}}-form">
                                                <input type="text" name="discount_title[]" class="form-control"
                                                       placeholder="{{translate('discount_title')}}">
                                                <label>{{translate('discount_title')}} ({{strtoupper($lang['code'])}})</label>
                                                <span class="material-icons">title</span>
                                            </div>
                                            <input type="hidden" name="lang[]" value="{{$lang['code']}}">
                                        @endforeach
                                    @else
                                        <div class="form-floating form-floating__icon mb-30">
                                            <input type="text" name="discount_title[]" class="form-control"
                                                   placeholder="{{translate('discount_title')}}" required>
                                            <label>{{translate('discount_title')}}</label>
                                            <span class="material-icons">title</span>
                                        </div>
                                        <input type="hidden" name="lang[]" value="default">
                                    @endif
                                    <div class="mb-30" id="category_selector">
                                        <label class="mb-2">{{ translate('Select Categories') }} *</label>
                                        <select class="category-select theme-input-style w-100" name="category_ids[]"
                                                multiple="multiple" id="category_selector__select"
                                                data-placeholder="{{ translate('Select Category') }}">
                                            <option value="all">{{translate('Select All')}}</option>
                                            @foreach($categories as $category)
                                                <option value="{{$category->id}}">{{$category->name}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="mb-30 service_selector" id="service_selector" style="display: none">
                                        <label class="mb-2">{{ translate('Select Services') }} *</label>
                                        <select class="service-select theme-input-style w-100" name="service_ids[]"
                                                multiple="multiple" id="service_selector__select"
                                                data-placeholder="{{ translate('Select Service') }}">
                                            <option value="all">{{translate('Select All')}}</option>
                                            @foreach($services as $service)
                                                <option value="{{$service->id}}">{{$service->name}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="mb-30" id="zone_selector">
                                        <label class="mb-2">{{ translate('Select Zones') }} *</label>
                                        <select class="zone-select theme-input-style w-100" name="zone_ids[]"
                                                multiple="multiple" id="zone_selector__select"
                                                data-placeholder="{{ translate('Select Zone') }}">
                                            <option value="all">{{translate('Select All')}}</option>
                                            @foreach($zones as $zone)
                                                <option value="{{$zone->id}}">{{$zone->name}}</option>
                                            @endforeach
                                        </select>
                                    </div>

                                    @include('promotionmanagement::admin.partials.provider-selector', [
                                        'providerRoute' => route('admin.coupon.get-providers'),
                                    ])
                                </div>

                                <div class="discount-amount-type">
                                    <div class="mb-3">{{translate('discount_amount_type')}}</div>
                                    <div class="d-flex flex-wrap align-items-center gap-4 mb-30">
                                        <div class="custom-radio">
                                            <input type="radio" id="percentage" name="discount_amount_type"
                                                   value="percent" checked>
                                            <label for="percentage">{{translate('percentage')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="fixed_amount" name="discount_amount_type"
                                                   value="amount">
                                            <label for="fixed_amount">{{translate('fixed_amount')}}</label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" name="discount_amount"
                                                           placeholder="{{translate('amount')}}" id="discount_amount"
                                                           min="0.01" max="100" step="any" required>
                                                    <label id="discount_amount__label">{{translate('amount')}}
                                                        (%) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating">
                                                    <input type="date" class="form-control" name="start_date"
                                                           value="{{now()->format('Y-m-d')}}">
                                                    <label>{{translate('Start_Date')}}</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating">
                                                    <input type="date" class="form-control" name="end_date"
                                                           value="{{now()->addDays(2)->format('Y-m-d')}}">
                                                    <label>{{translate('End_Date')}}</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" step="any"
                                                           name="min_purchase"
                                                           placeholder="{{translate('min_purchase')}} ({{currency_symbol()}})"
                                                           min="0" value="0">
                                                    <label>{{translate('min_purchase')}} ({{currency_symbol()}}) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="max_discount_amount">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" step="any"
                                                           name="max_discount_amount"
                                                           placeholder="{{translate('max_discount')}} ({{currency_symbol()}})"
                                                           min="0" value="0">
                                                    <label>{{translate('max_discount')}} ({{currency_symbol()}}) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                                <small class="text-muted d-block mt-1">{{ translate('Keep 0 for no limit') }}</small>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="limit_per_user__div">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" name="limit_per_user"
                                                           id="limit_per_user" placeholder="1" value="1" min="1">
                                                    <label>{{translate('Limit For Same User')}} *</label>
                                                    <span class="material-icons">person</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-end gap-3">
                                    <button type="reset" class="btn btn--secondary">{{translate('reset')}}</button>
                                    <button type="submit" class="btn btn--primary">{{translate('submit')}}</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script')
    <script>
        "use strict";

        (function () {
            var $category = $('#category_selector__select');
            var $service = $('#service_selector__select');
            var $zone = $('#zone_selector__select');
            var $customer = $('#customer-select');
            var $couponType = $('#coupon-type');

            function initSelect($el, placeholder) {
                if (!$el.length || typeof $.fn.select2 === 'undefined') return;
                if ($el.data('select2')) return;
                $el.select2({
                    width: '100%',
                    closeOnSelect: false,
                    placeholder: placeholder || $el.attr('data-placeholder') || ''
                });
            }

            // width: '100%' zaroori hai â€” hidden div ke andar select2 default
            // width 0 le leta hai (customer select / service select).
            initSelect($category, "{{ translate('Select Category') }}");
            initSelect($service, "{{ translate('Select Service') }}");
            initSelect($zone, "{{ translate('Select Zone') }}");
            initSelect($customer, "{{ translate('Select customer') }}");

            if (typeof $.fn.select2 !== 'undefined' && !$couponType.data('select2')) {
                $couponType.select2({width: '100%'});
            }

            // "Select All" â€” pehle sirf option me selected flag lagta tha,
            // select2 ka UI refresh nahi hota tha, isliye user ko lagta tha
            // ki kuch select hi nahi hua.
            $('#category_selector__select, #service_selector__select, #zone_selector__select, #customer-select').on('change', function () {
                var $el = $(this);
                var values = $el.val() || [];

                if (values.indexOf('all') === -1) return;

                $el.find('option').each(function () {
                    var $option = $(this);
                    if ($option.val() === 'all' || $option.prop('disabled')) return;
                    $option.prop('selected', true);
                });
                $el.find('option[value="all"]').prop('selected', false);
                // plain change -> select2 UI refresh + provider cascade reload
                $el.trigger('change');
            });

            function toggleDiscountType() {
                var type = $('input[name="discount_type"]:checked').val() || 'category';
                $('#category_selector').toggle(type === 'category' || type === 'mixed');
                $('#service_selector').toggle(type === 'service' || type === 'mixed');
            }

            $('input[name="discount_type"]').on('change', toggleDiscountType);
            toggleDiscountType();

            function toggleAmountType() {
                var type = $('input[name="discount_amount_type"]:checked').val() || 'percent';
                if (type === 'percent') {
                    $('#max_discount_amount').show();
                    $('#discount_amount').attr('max', 100);
                    $('#discount_amount__label').html("{{ translate('amount') }} (%) *");
                } else {
                    $('#max_discount_amount').hide();
                    $('#discount_amount').removeAttr('max');
                    $('#discount_amount__label').html("{{ translate('amount') }} ({{ currency_symbol() }}) *");
                }
            }

            $('input[name="discount_amount_type"]').on('change', toggleAmountType);
            toggleAmountType();

            function toggleCouponType() {
                var type = $couponType.val();
                $('#customer-select__div').toggleClass('d-none', type !== 'customer_wise');
                $('#limit_per_user__div').toggleClass('d-none', type === 'first_booking');
            }

            $couponType.on('change', toggleCouponType);
            toggleCouponType();

            // HTML5 "required" select2 ke chhupe hue select par silently fail
            // ho jata hai (form submit hi nahi hota, koi error bhi nahi dikhta).
            // Isliye validation yahan saaf message ke saath karte hain.
            $('.main-content form').on('submit', function (e) {
                function fail(message, $select) {
                    e.preventDefault();
                    if (typeof toastr !== 'undefined') {
                        toastr.error(message);
                    } else {
                        alert(message);
                    }
                    if ($select && $select.length && $select.data('select2')) {
                        $select.select2('open');
                    }
                    return false;
                }

                var discountType = $('input[name="discount_type"]:checked').val() || 'category';
                var couponType = $couponType.val();

                if (!couponType) {
                    return fail({!! json_encode(translate('Select coupon type')) !!}, $couponType);
                }
                if (($zone.val() || []).length === 0) {
                    return fail({!! json_encode(translate('Select at least one zone')) !!}, $zone);
                }
                if ((discountType === 'category' || discountType === 'mixed') && ($category.val() || []).length === 0) {
                    return fail({!! json_encode(translate('Select at least one category')) !!}, $category);
                }
                if ((discountType === 'service' || discountType === 'mixed') && ($service.val() || []).length === 0) {
                    return fail({!! json_encode(translate('Select at least one service')) !!}, $service);
                }
                if (couponType === 'customer_wise' && ($customer.val() || []).length === 0) {
                    return fail({!! json_encode(translate('Select at least one customer')) !!}, $customer);
                }
                return true;
            });

            $(".lang_link").on('click', function (e) {
                e.preventDefault();
                $(".lang_link").removeClass('active');
                $(".lang-form").addClass('d-none');
                $(this).addClass('active');

                var form_id = this.id;
                var lang = form_id.substring(0, form_id.length - 5);
                $("#" + lang + "-form").removeClass('d-none');
            });
        })();
    </script>
@endpush

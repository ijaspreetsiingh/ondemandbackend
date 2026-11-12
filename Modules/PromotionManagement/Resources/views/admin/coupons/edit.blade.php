@extends('adminmodule::layouts.master')

@section('title',translate('update_coupon'))

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-wrap mb-3">
                        <h2 class="page-title">{{translate('update_coupon')}}</h2>
                    </div>
                    <div class="card mb-30">
                        <div class="card-body p-30">
                            <form action="{{route('admin.coupon.update',[$coupon->id])}}" method="POST">
                                @method('PUT')
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
                                <div class="coupon-type">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="mb-30">
                                                <select class="js-select theme-input-style w-100" name="coupon_type"
                                                        id="coupon-type">
                                                    <option>{{translate('select_coupon_type')}}</option>
                                                    @foreach(COUPON_TYPES as $index=>$coupon_type)
                                                        <option
                                                            value="{{$index}}" {{$coupon->coupon_type==$index?'selected':''}}>
                                                            {{$coupon_type}}
                                                        </option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="text" class="form-control" name="coupon_code"
                                                           value="{{$coupon->coupon_code}}"
                                                           placeholder="{{translate('coupon_code')}}">
                                                    <label>{{translate('coupon_code')}} *</label>
                                                    <span class="material-icons">subtitles</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div
                                            class="col-12 {{$coupon['coupon_type'] != 'customer_wise' ? 'd-none' : ''}}"
                                            id="customer-select__div">
                                            <div class="mb-30">
                                                <select class="js-select theme-input-style w-100" id="customer-select"
                                                        name="customer_user_ids[]" multiple
                                                        data-placeholder="{{ translate('Select customer') }}">
                                                    <option value="all">{{translate('Select All')}}</option>
                                                    @foreach($customers as $key=>$customer)
                                                        <option value="{{$customer->id}}"
                                                            {{$coupon->coupon_customers->contains('customer_user_id', $customer->id) ? 'selected' : ''}}>
                                                            {{$customer->first_name .' '. $customer->last_name}}
                                                        </option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">{{translate('discount_type')}}</div>
                                    <div class="d-flex flex-wrap align-items-center gap-4 mb-30">
                                        <div class="custom-radio">
                                            <input type="radio" id="category" name="discount_type"
                                                   value="category" {{$coupon->discount->discount_type=='category'?'checked':''}}>
                                            <label for="category">{{translate('category_wise')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="service" name="discount_type"
                                                   value="service" {{$coupon->discount->discount_type=='service'?'checked':''}}>
                                            <label for="service">{{translate('service_wise')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="mixed" name="discount_type"
                                                   value="mixed" {{$coupon->discount->discount_type=='mixed'?'checked':''}}>
                                            <label for="mixed">{{translate('mixed')}}</label>
                                        </div>
                                    </div>
                                    @if ($language)
                                        <div class="form-floating form-floating__icon mb-30 lang-form" id="default-form">
                                            <input type="text" name="discount_title[]" class="form-control"
                                                   placeholder="{{translate('discount_title')}}"
                                                   value="{{$discount?->getRawOriginal('discount_title')}}" required>
                                            <label>{{translate('discount_title')}} ({{ translate('default') }})</label>
                                            <span class="material-icons">title</span>
                                        </div>
                                        <input type="hidden" name="lang[]" value="default">
                                        @foreach ($language?->live_values as $lang)
                                                <?php
                                                if (count($discount['translations'])) {
                                                    $translate = [];
                                                    foreach ($discount['translations'] as $t) {
                                                        if ($t->locale == $lang['code'] && $t->key == "discount_title") {
                                                            $translate[$lang['code']]['discount_title'] = $t->value;
                                                        }
                                                    }
                                                }
                                                ?>

                                            <div class="form-floating form-floating__icon mb-30 d-none lang-form"
                                                 id="{{$lang['code']}}-form">
                                                <input type="text" name="discount_title[]" class="form-control"
                                                       placeholder="{{translate('discount_title')}}"
                                                       value="{{$translate[$lang['code']]['discount_title'] ?? ''}}">
                                                <label>{{translate('discount_title')}} ({{strtoupper($lang['code'])}}
                                                    )</label>
                                                <span class="material-icons">title</span>

                                            </div>
                                            <input type="hidden" name="lang[]" value="{{$lang['code']}}">
                                        @endforeach
                                    @else
                                        <div class="form-floating form-floating__icon mb-30">
                                            <input type="text" name="discount_title[]" class="form-control"
                                                   placeholder="{{translate('discount_title')}}"
                                                   value="{{$discount->discount_title}}" required>
                                            <label>{{translate('discount_title')}}</label>
                                            <span class="material-icons">title</span>
                                        </div>
                                        <input type="hidden" name="lang[]" value="default">
                                    @endif
                                    <div class="mb-30" id="category_selector"
                                         style="display: {{($coupon->discount->discount_type=='category' || $coupon->discount->discount_type=='mixed')?'block':'none'}}">
                                        <label class="mb-2">{{ translate('Select Categories') }} *</label>
                                        <select class="category-select theme-input-style w-100" name="category_ids[]"
                                                multiple="multiple"
                                                id="category_selector__select"
                                                data-placeholder="{{ translate('Select Category') }}">
                                            <option value="all">{{translate('Select All')}}</option>
                                            @foreach($categories as $category)
                                                <option
                                                    value="{{$category->id}}" {{in_array($category->id,$coupon->discount->category_types->pluck('type_wise_id')->toArray())?'selected':''}}>
                                                    {{$category->name}}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="mb-30" id="service_selector"
                                         style="display: {{($coupon->discount->discount_type=='service' || $coupon->discount->discount_type=='mixed')?'block':'none'}}">
                                        <label class="mb-2">{{ translate('Select Services') }} *</label>
                                        <select class="service-select theme-input-style w-100" name="service_ids[]"
                                                multiple="multiple" id="service_selector__select"
                                                data-placeholder="{{ translate('Select Service') }}">
                                            <option value="all">{{translate('Select All')}}</option>
                                            @foreach($services as $service)
                                                <option
                                                    value="{{$service->id}}" {{in_array($service->id,$coupon->discount->service_types->pluck('type_wise_id')->toArray())?'selected':''}}>
                                                    {{$service->name}}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="mb-30">
                                        <label class="mb-2">{{ translate('Select Zones') }} *</label>
                                        <select class="zone-select theme-input-style w-100" name="zone_ids[]"
                                                multiple="multiple" id="zone_selector__select"
                                                data-placeholder="{{ translate('Select Zone') }}">
                                            <option value="all">{{translate('Select All')}}</option>
                                            @foreach($zones as $zone)
                                                <option
                                                    value="{{$zone->id}}" {{in_array($zone->id,$coupon->discount->zone_types->pluck('type_wise_id')->toArray())?'selected':''}}>
                                                    {{$zone->name}}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>

                                    @include('promotionmanagement::admin.partials.provider-selector', [
                                        'providerRoute' => route('admin.coupon.get-providers'),
                                        'selectedProviderIds' => $coupon->discount->provider_types->pluck('type_wise_id')->toArray(),
                                    ])
                                </div>

                                <div class="coupon-amount-type">
                                    <div class="mb-3">{{translate('discount_amount_type')}}</div>
                                    <div class="d-flex flex-wrap align-items-center gap-4 mb-30">
                                        <div class="custom-radio">
                                            <input type="radio" id="percentage" name="discount_amount_type"
                                                   value="percent" {{$coupon->discount->discount_amount_type=='percent'?'checked':''}}>
                                            <label for="percentage">{{translate('percentage')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="fixed_amount" name="discount_amount_type"
                                                   value="amount" {{$coupon->discount->discount_amount_type=='amount'?'checked':''}}>
                                            <label for="fixed_amount">{{translate('fixed_amount')}}</label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" name="discount_amount"
                                                           value="{{$coupon->discount->discount_amount}}"
                                                           id="discount_amount"
                                                           placeholder="{{translate('amount')}}" step="any"
                                                           min="0.01" {{$coupon->discount->discount_amount_type == 'percent'? 'max=100' : ''}}>
                                                    <label id="discount_amount__label">{{translate('amount')}}
                                                        ({{$coupon->discount->discount_amount_type == 'amount' ? currency_symbol() : '%'}}) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating">
                                                    <input type="date" class="form-control" name="start_date"
                                                           value="{{$coupon->discount->start_date}}">
                                                    <label>{{translate('start_date')}}</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating">
                                                    <input type="date" class="form-control" name="end_date"
                                                           value="{{$coupon->discount->end_date}}">
                                                    <label>{{translate('end_date')}}</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" step="any"
                                                           name="min_purchase"
                                                           placeholder="{{translate('min_purchase')}} ({{currency_symbol()}})"
                                                           value="{{$coupon->discount->min_purchase}}"
                                                           min="0">
                                                    <label>{{translate('min_purchase')}} ({{currency_symbol()}}) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="max_discount_amount"
                                             style="display: {{$coupon->discount->discount_amount_type=='amount'?'none':'block'}}">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" step="any"
                                                           name="max_discount_amount"
                                                           placeholder="{{translate('max_discount_amount')}} ({{currency_symbol()}})"
                                                           value="{{$coupon->discount->max_discount_amount}}"
                                                           min="0">
                                                    <label>{{translate('max_discount')}} ({{currency_symbol()}}) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                                <small class="text-muted d-block mt-1">{{ translate('Keep 0 for no limit') }}</small>
                                            </div>
                                        </div>
                                        <div
                                            class="col-lg-4 {{$coupon['coupon_type'] == 'first_booking' ? 'd-none' : ''}}"
                                            id="limit_per_user__div">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" name="limit_per_user"
                                                           value="{{$coupon->discount?->limit_per_user ?? 1}}"
                                                           id="limit_per_user" min="1"
                                                           placeholder="1">
                                                    <label>{{translate('Limit For Same User')}} *</label>
                                                    <span class="material-icons">person</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-end gap-3">
                                    <button type="reset" class="btn btn--secondary">{{translate('reset')}}</button>
                                    <button type="submit" class="btn btn--primary">{{translate('update')}}</button>
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

            initSelect($category, "{{ translate('Select Category') }}");
            initSelect($service, "{{ translate('Select Service') }}");
            initSelect($zone, "{{ translate('Select Zone') }}");
            initSelect($customer, "{{ translate('Select customer') }}");

            if (typeof $.fn.select2 !== 'undefined' && !$couponType.data('select2')) {
                $couponType.select2({width: '100%'});
            }

            // "Select All" â€” select2 ka UI bhi refresh hona chahiye.
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

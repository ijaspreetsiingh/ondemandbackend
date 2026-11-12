@extends('adminmodule::layouts.master')

@section('title',translate('add_new_discount'))

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-wrap mb-3 d-flex justify-content-between">
                        <h2 class="page-title">{{translate('add_new_discount')}}</h2>
                        <div><i class="material-icons" data-bs-toggle="modal" data-bs-target="#alertModal">info</i></div>
                    </div>
                    <div class="card mb-30">
                        <div class="card-body p-30">
                            <form action="{{route('admin.discount.store')}}" method="POST">
                                @csrf

                                <!-- STEP 1: SELECT CATEGORY OR SERVICE -->
                                <div class="discount-type mb-30">
                                    <h5 class="mb-3">{{ translate('Step 1: Select Type') }}</h5>
                                    <div class="d-flex flex-wrap align-items-center gap-4 mb-30">
                                        <div class="custom-radio">
                                            <input type="radio" id="category" name="discount_type" value="category" checked>
                                            <label for="category">{{translate('category_wise')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="service" name="discount_type" value="service">
                                            <label for="service">{{translate('service_wise')}}</label>
                                        </div>
                                    </div>

                                    <div class="mb-30">
                                        <div class="form-floating form-floating__icon">
                                            <input type="text" class="form-control" name="discount_title"
                                                   placeholder="{{translate('discount_title')}} *"
                                                   required="" maxlength="191">
                                            <label>{{translate('discount_title')}} *</label>
                                            <span class="material-icons">title</span>
                                        </div>
                                    </div>

                                    <!-- Category Selector -->
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

                                    <!-- Service Selector -->
                                    <div class="mb-30 service_selector" id="service_selector" style="display: none;">
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
                                </div>

                                <hr class="my-4">

                                <!-- STEP 2: SELECT ZONE -->
                                <div class="zone-selector mb-30">
                                    <h5 class="mb-3">{{ translate('Step 2: Select Zone') }}</h5>
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

                                <!-- STEP 3: SELECT PROVIDERS (Dynamic based on Zone + Category/Service) -->
                                @include('promotionmanagement::admin.partials.provider-selector', [
                                    'heading' => translate('Step 3: Select Providers'),
                                    'providerRoute' => route('admin.discount.get-providers'),
                                ])

                                <hr class="my-4">

                                <!-- DISCOUNT AMOUNT CONFIGURATION -->
                                <div class="discount-amount-type">
                                    <h5 class="mb-3">{{ translate('Step 4: Discount Configuration') }}</h5>

                                    <div class="mb-3">{{translate('discount_amount_type')}} *</div>
                                    <div class="d-flex align-items-center gap-4 mb-30">
                                        <div class="custom-radio">
                                            <input type="radio" id="percentage" name="discount_amount_type" value="percent" checked>
                                            <label for="percentage">{{translate('percentage')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="fixed_amount" name="discount_amount_type" value="amount">
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
                                                    <label id="discount_amount__label">{{translate('amount')}} (%) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating">
                                                    <input type="date" class="form-control" name="start_date" value="{{now()->format('Y-m-d')}}" required>
                                                    <label>{{translate('start_date')}} *</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating">
                                                    <input type="date" class="form-control" name="end_date" value="{{now()->addDays(2)->format('Y-m-d')}}" required>
                                                    <label>{{translate('end_date')}} *</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control"
                                                           name="min_purchase"
                                                           placeholder="{{translate('min_purchase')}} ({{currency_symbol()}}) *"
                                                           min="0" value="0" step="any" required>
                                                    <label>{{translate('min_purchase_amount')}} ({{currency_symbol()}}) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="max_discount_amount">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" step="any"
                                                           name="max_discount_amount"
                                                           placeholder="{{translate('max_discount')}} ({{currency_symbol()}}) *"
                                                           min="0" value="0">
                                                    <label>{{translate('max_discount')}} ({{currency_symbol()}}) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                                <small class="text-muted d-block mt-1">{{ translate('Keep 0 for no limit') }}</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end gap-3 mt-4">
                                    <a href="{{ route('admin.discount.list') }}" class="btn btn--secondary">{{ translate('Cancel') }}</a>
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
            // width 0 le leta hai (service select invisible ho jata tha).
            initSelect($category, "{{ translate('Select Category') }}");
            initSelect($service, "{{ translate('Select Service') }}");
            initSelect($zone, "{{ translate('Select Zone') }}");

            // "Select All" ke baad select2 ka UI refresh hona chahiye, warna
            // user ko lagta hai ki kuch select hua hi nahi.
            $('#category_selector__select, #service_selector__select, #zone_selector__select').on('change', function () {
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

            // HTML5 "required" select2 ke chhupe hue select par silently fail
            // ho jata hai (form submit hi nahi hota, koi error bhi nahi dikhta).
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

                if (($zone.val() || []).length === 0) {
                    return fail({!! json_encode(translate('Select at least one zone')) !!}, $zone);
                }
                if ((discountType === 'category' || discountType === 'mixed') && ($category.val() || []).length === 0) {
                    return fail({!! json_encode(translate('Select at least one category')) !!}, $category);
                }
                if ((discountType === 'service' || discountType === 'mixed') && ($service.val() || []).length === 0) {
                    return fail({!! json_encode(translate('Select at least one service')) !!}, $service);
                }
                return true;
            });
        })();
    </script>
@endpush

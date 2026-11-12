@extends('adminmodule::layouts.master')

@section('title',translate('update_discount'))

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-wrap mb-3 d-flex justify-content-between">
                        <h2 class="page-title">{{translate('update_discount')}}</h2>

                        <div><i class="material-icons" data-bs-toggle="modal" data-bs-target="#alertModal">info</i></div>
                    </div>
                    <div class="card mb-30">
                        <div class="card-body p-30">
                            <form action="{{route('admin.discount.update',[$discount->id])}}" method="POST">
                                @method('PUT')
                                @csrf
                                <div class="discount-type">
                                    <div class="mb-3">{{translate('discount_type')}}</div>
                                    <div class="d-flex flex-wrap align-items-center gap-4 mb-30">
                                        <div class="custom-radio">
                                            <input type="radio" id="category" name="discount_type"
                                                   value="category" {{$discount->discount_type=='category'?'checked':''}}>
                                            <label for="category">{{translate('category_wise')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="service" name="discount_type" value="service"
                                                {{$discount->discount_type=='service'?'checked':''}}>
                                            <label for="service">{{translate('service_wise')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="mixed" name="discount_type"
                                                   value="mixed" {{$discount->discount_type=='mixed'?'checked':''}}>
                                            <label for="mixed">{{translate('mixed')}}</label>
                                        </div>
                                    </div>

                                    <div class="mb-30">
                                        <div class="form-floating form-floating__icon">
                                            <input type="text" class="form-control" name="discount_title"
                                                   placeholder="{{translate('discount_title')}} *" value="{{$discount->discount_title}}"
                                                   required="" maxlength="191">
                                            <label>{{translate('discount_title')}} *</label>
                                            <span class="material-icons">title</span>
                                        </div>
                                    </div>
                                    <div class="mb-30" id="category_selector"
                                         style="display: {{($discount->discount_type=='category' || $discount->discount_type=='mixed')?'block':'none'}}">
                                        <label class="mb-2">{{ translate('Select Categories') }} *</label>
                                        <select class="category-select theme-input-style w-100" name="category_ids[]"
                                                multiple="multiple" id="category_selector__select"
                                                data-placeholder="{{ translate('Select Category') }}">
                                            <option value="all">{{translate('Select All')}}</option>
                                            @foreach($categories as $category)
                                                <option value="{{$category->id}}" {{in_array($category->id,$discount->category_types->pluck('type_wise_id')->toArray())?'selected':''}}>
                                                    {{$category->name}}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="mb-30" id="service_selector"
                                         style="display: {{($discount->discount_type=='service' || $discount->discount_type=='mixed')?'block':'none'}}">
                                        <label class="mb-2">{{ translate('Select Services') }} *</label>
                                        <select class="service-select theme-input-style w-100" name="service_ids[]"
                                                multiple="multiple" id="service_selector__select"
                                                data-placeholder="{{ translate('Select Service') }}">
                                            <option value="all">{{translate('Select All')}}</option>
                                            @foreach($services as $service)
                                                <option value="{{$service->id}}" {{in_array($service->id,$discount->service_types->pluck('type_wise_id')->toArray())?'selected':''}}>
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
                                                <option value="{{$zone->id}}" {{in_array($zone->id,$discount->zone_types->pluck('type_wise_id')->toArray())?'selected':''}}>
                                                    {{$zone->name}}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>

                                    @include('promotionmanagement::admin.partials.provider-selector', [
                                        'providerRoute' => route('admin.discount.get-providers'),
                                        'selectedProviderIds' => $discount->provider_types->pluck('type_wise_id')->toArray(),
                                    ])
                                </div>

                                <div class="discount-amount-type">
                                    <div class="mb-3 text-capitalize">{{translate('discount_amount_type')}} *</div>
                                    <div class="d-flex align-items-center gap-4 mb-30">
                                        <div class="custom-radio">
                                            <input type="radio" id="percentage" name="discount_amount_type" value="percent" {{$discount->discount_amount_type=='percent'?'checked':''}}>
                                            <label for="percentage">{{translate('percentage')}}</label>
                                        </div>
                                        <div class="custom-radio">
                                            <input type="radio" id="fixed_amount" name="discount_amount_type" value="amount" {{$discount->discount_amount_type=='amount'?'checked':''}}>
                                            <label for="fixed_amount">{{translate('fixed_amount')}}</label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" name="discount_amount" id="discount_amount"
                                                           value="{{$discount->discount_amount}}"
                                                           placeholder="{{translate('amount')}} *" step="any"
                                                           min="0.01" {{$discount->discount_amount_type == 'percent'? 'max=100' : ''}}>
                                                    <label id="discount_amount__label">{{translate('amount')}} ({{$discount->discount_amount_type == 'amount' ? currency_symbol() : '%'}})</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating">
                                                    <input type="date" class="form-control" name="start_date" value="{{$discount->start_date}}">
                                                    <label>{{translate('start_date')}} *</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating">
                                                    <input type="date" class="form-control" name="end_date" value="{{$discount->end_date}}">
                                                    <label>{{translate('end_date')}} *</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" step="any"
                                                           name="min_purchase"
                                                           placeholder="{{translate('min_purchase')}} ({{currency_symbol()}}) *"
                                                           value="{{$discount->min_purchase}}"
                                                           min="0">
                                                    <label>{{translate('min_purchase_amount')}} ({{currency_symbol()}}) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="max_discount_amount"
                                             style="display: {{$discount->discount_amount_type=='amount'?'none':'block'}}">
                                            <div class="mb-30">
                                                <div class="form-floating form-floating__icon">
                                                    <input type="number" class="form-control" step="any"
                                                           name="max_discount_amount"
                                                           placeholder="{{translate('max_discount')}} ({{currency_symbol()}}) *"
                                                           value="{{$discount->max_discount_amount}}"
                                                           min="0">
                                                    <label>{{translate('max_discount')}} ({{currency_symbol()}}) *</label>
                                                    <span class="material-icons">price_change</span>
                                                </div>
                                                <small class="text-muted d-block mt-1">{{ translate('Keep 0 for no limit') }}</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn--primary">{{translate('update')}}</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header pb-0 border-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body pb-sm-5 px-sm-5">
                    <div class="d-flex flex-column align-items-center gap-2 text-center">
                        <h3>{{translate('Alert')}}!</h3>
                        <p class="fw-medium">
                            {{translate('This request is with customized instructions. Please read the customer description and instructions thoroughly and place your pricing according to this')}}
                        </p>
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

            initSelect($category, "{{ translate('Select Category') }}");
            initSelect($service, "{{ translate('Select Service') }}");
            initSelect($zone, "{{ translate('Select Zone') }}");

            // "Select All" â€” select2 ka UI bhi refresh hona chahiye.
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

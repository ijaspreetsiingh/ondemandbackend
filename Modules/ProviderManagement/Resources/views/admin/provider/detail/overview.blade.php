@extends('adminmodule::layouts.master')

@section('title',translate('provider_details'))

@push('css_or_js')

@endpush

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="page-title-wrap mb-3">
                <h2 class="page-title">{{translate('Provider_Details')}}</h2>
            </div>

            <div class="mb-3">
                <ul class="nav nav--tabs nav--tabs__style2">
                    <li class="nav-item">
                        <a class="nav-link {{$webPage=='overview'?'active':''}}"
                           href="{{url()->current()}}?web_page=overview">{{translate('Overview')}}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {{$webPage=='subscribed_services'?'active':''}}"
                           href="{{url()->current()}}?web_page=subscribed_services">{{translate('Subscribed_Services')}}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {{$webPage=='bookings'?'active':''}}"
                           href="{{url()->current()}}?web_page=bookings">{{translate('Bookings')}}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {{$webPage=='serviceman_list'?'active':''}}"
                           href="{{url()->current()}}?web_page=serviceman_list">{{translate('Service_Man_List')}}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {{$webPage=='settings'?'active':''}}"
                           href="{{url()->current()}}?web_page=settings">{{translate('Settings')}}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {{$webPage=='bank_information'?'active':''}}"
                           href="{{url()->current()}}?web_page=bank_information">{{translate('Bank_Information')}}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {{$webPage=='reviews'?'active':''}}"
                           href="{{url()->current()}}?web_page=reviews">{{translate('Reviews')}}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {{$webPage=='subscription'?'active':''}}"
                           href="{{url()->current()}}?web_page=subscription&provider_id={{ request()->id }}">{{translate('Business Plan')}}</a>
                    </li>
                </ul>
            </div>

            <div class="card">
                <div class="card-body p-30">
                    @php
                        $providerAccount = optional(optional($provider->owner)->account);
                        $extraChargeOwners = is_array($provider->extra_charge_owners) ? $provider->extra_charge_owners : [];
                        $allowedPaymentMethods = $provider->allowed_payment_methods;
                        if (is_string($allowedPaymentMethods)) {
                            $allowedPaymentMethods = json_decode($allowedPaymentMethods, true);
                        }
                        $allowedPaymentMethods = is_array($allowedPaymentMethods) ? $allowedPaymentMethods : [];
                        $chargeOwnerLabels = chargeOwnerOptions();
                    @endphp
                    @if($provider->is_approved == 1)
                        <div class="provider-details-overview mb-30">
                            <div class="provider-details-overview__collect-cash">
                                <div class="statistics-card statistics-card__collect-cash h-100">
                                    <h3>{{translate('Collect_Cash_From_Provider')}}</h3>
                                    <h2>{{with_currency_symbol($providerAccount->account_payable ?? 0)}}</h2>
                                    @can('provider_update')
                                        <a href="{{route('admin.provider.collect_cash.list', [$provider->id])}}"
                                           class="btn btn--primary text-capitalize w-100 btn--lg mw-75">{{translate('Collect_Cash')}}</a>
                                    @endcan
                                </div>
                            </div>
                            <div class="provider-details-overview__statistics">

                                <div
                                    class="statistics-card statistics-card__style2 statistics-card__pending-withdraw">
                                    <h2>{{with_currency_symbol($providerAccount->balance_pending ?? 0)}}</h2>
                                    <h3>{{translate('Pending_Withdrawn')}}</h3>
                                </div>

                                <div
                                    class="statistics-card statistics-card__style2 statistics-card__already-withdraw">
                                    <h2>{{with_currency_symbol($providerAccount->total_withdrawn ?? 0)}}</h2>
                                    <h3>{{translate('Already_Withdrawn')}}</h3>
                                </div>

                                <div
                                    class="statistics-card statistics-card__style2 statistics-card__withdrawable-amount">
                                    <h2>{{with_currency_symbol($providerAccount->account_receivable ?? 0)}}</h2>
                                    <h3>{{translate('Withdrawable_Amount')}}</h3>
                                </div>

                                <div
                                    class="statistics-card statistics-card__style2 statistics-card__total-earning">
                                    <h2>{{ with_currency_symbol(($providerAccount->received_balance ?? 0) + ($providerAccount->total_withdrawn ?? 0)) }}</h2>
                                    <h3>{{translate('Total_Earning')}}</h3>
                                </div>
                            </div>
                            <div class="provider-details-overview__order-overview">
                                <div class="statistics-card statistics-card__order-overview h-100 pb-2">
                                    <h3 class="mb-0">{{translate('Booking_Overview')}}</h3>
                                    <div id="apex-pie-chart" class="d-flex justify-content-center"></div>
                                </div>
                            </div>
                        </div>
                    @endif
                    <div class="d-flex align-items-center flex-wrap-reverse justify-content-between gap-3 mb-3">
                        <h2>{{translate('Information_Details')}}</h2>
                        <div class="d-flex align-items-center flex-wrap gap-3">
                            @if($provider->is_approved == 2)
                                <a type="button"
                                   class="btn btn-soft--danger text-capitalize provider_approval"
                                   id="button-deny-{{$provider->id}}" data-approve="{{$provider->id}}"
                                   data-status="deny">
                                    {{translate('Deny')}}
                                </a>
                            @endif
                            @if($provider->is_approved == 0 || $provider->is_approved == 2)
                                <a type="button" class="btn btn--success text-capitalize approval_provider"
                                   id="button-{{$provider->id}}" data-approve="{{$provider->id}}"
                                   data-approve="approve">
                                    {{translate('Accept')}}
                                </a>
                            @endif

                            @can('provider_update')
                                <a href="{{route('admin.provider.edit',[$provider->id])}}" class="btn btn--primary">
                                    <span class="material-icons">border_color</span>
                                    {{translate('Edit')}}
                                </a>
                            @endcan
                        </div>
                    </div>

                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="information-details-box media flex-column flex-sm-row gap-20">
                                <img class="avatar-img radius-5" src="{{ $provider->logoFullPath }}" alt="{{ translate('logo') }}">
                                <div class="media-body ">
                                    <h2 class="information-details-box__title">{{Str::limit($provider->company_name, 30)}}</h2>

                                    <ul class="contact-list">
                                        <li>
                                            <span class="material-symbols-outlined">phone_iphone</span>
                                            <a href="tel:{{$provider->company_phone}}">{{$provider->company_phone}}</a>
                                        </li>
                                        <li>
                                            <span class="material-symbols-outlined">mail</span>
                                            <a href="mailto:{{$provider->company_email}}">{{$provider->company_email}}</a>
                                        </li>
                                        <li>
                                            <span class="material-symbols-outlined">map</span>
                                            {{Str::limit($provider->company_address, 100)}}
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="information-details-box h-100">
                                <h2 class="information-details-box__title c1">{{translate('Contact_Person_Information')}}
                                </h2>
                                <h3 class="information-details-box__subtitle">{{Str::limit($provider->contact_person_name, 30)}}</h3>

                                <ul class="contact-list">
                                    <li>
                                        <span class="material-symbols-outlined">phone_iphone</span>
                                        <a href="tel:{{$provider->contact_person_phone}}">{{$provider->contact_person_phone}}</a>
                                    </li>
                                    <li>
                                        <span class="material-symbols-outlined">mail</span>
                                        <a href="mailto:{{$provider->contact_person_email}}">{{$provider->contact_person_email}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="information-details-box">
                                <div class="row g-4">
                                    <div class="col-lg-3">
                                        <h2 class="information-details-box__title c1 mb-3">{{translate('Business_Info')}}
                                        </h2>
                                        <p><strong
                                                class="text-capitalize">{{translate($provider->owner->identification_type)}}
                                                -</strong> {{$provider->owner->identification_number}}</p>
                                    </div>
                                    <div class="col-lg-9">
                                        <div class="d-flex flex-wrap gap-3 justify-content-lg-end">
                                            @foreach($provider->owner->identification_image_full_path as $image)
                                                <img class="max-w320" src="{{ $image }}" alt="{{translate('image')}}">
                                            @endforeach
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mt-1">
                        <div class="col-lg-6">
                            <div class="information-details-box h-100">
                                <h2 class="information-details-box__title c1">{{translate('Business Coverage')}}</h2>
                                <ul class="contact-list">
                                    <li><strong>{{translate('Zone')}}:</strong>&nbsp;{{ optional($provider->zone)->name ?? translate('Not_Assigned') }}</li>
                                    <li><strong>{{translate('Main Category')}}:</strong>&nbsp;{{ optional($provider->assignedMainCategory)->name ?? translate('Based_on_category_assignments') }}</li>
                                    <li><strong>{{translate('Category Assignment')}}:</strong>&nbsp;{{ $provider->category_assignment_mode ? translate('Custom') : translate('Assigned_Categories') }}</li>
                                    <li><strong>{{translate('Provider Status')}}:</strong>&nbsp;{{ $provider->is_active ? translate('Active') : translate('Inactive') }} / {{ $provider->is_approved == 1 ? translate('Approved') : ($provider->is_approved == 2 ? translate('Pending') : translate('Not_Approved')) }}</li>
                                </ul>
                                @if($categoryAssignments->isNotEmpty())
                                    @foreach($categoryAssignments->groupBy('category_id') as $mainAssignments)
                                        @php
                                            $mainCategory = optional($mainAssignments->first()->category);
                                            $completeAssignments = $mainAssignments->where('assign_type', 'complete');
                                            $specificAssignments = $mainAssignments->where('assign_type', 'specific');
                                        @endphp
                                        <div class="border rounded p-3 mb-2 bg-white">
                                            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                                                <strong>{{ $mainCategory->name ?? translate('Unknown_Main_Category') }}</strong>
                                                <span class="badge badge-info">{{ $mainAssignments->where('is_subscribed', 1)->count() }} {{translate('Active')}}</span>
                                            </div>
                                            @if($completeAssignments->isNotEmpty())
                                                <div class="mt-2"><span class="badge badge-success">{{translate('Complete main category')}}</span> {{translate('All sub-categories')}}</div>
                                            @endif
                                            @if($specificAssignments->isNotEmpty())
                                                <div class="mt-2"><span class="badge badge-secondary">{{translate('Selected sub-categories')}}</span>
                                                    <div class="mt-1">{{ $specificAssignments->map(fn($assignment) => optional($assignment->sub_category)->name)->filter()->unique()->implode(', ') ?: translate('No_sub_categories') }}</div>
                                                </div>
                                            @endif
                                            @if($mainAssignments->where('is_subscribed', 0)->isNotEmpty())
                                                <small class="text-warning d-block mt-2">{{translate('Some_assignments_are_inactive')}}</small>
                                            @endif
                                        </div>
                                    @endforeach
                                @else
                                    <p class="text-muted mb-0">{{translate('No_category_assignments_found')}}</p>
                                @endif
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="information-details-box h-100">
                                <h2 class="information-details-box__title c1">{{translate('Commission and Payment Settings')}}</h2>
                                <ul class="contact-list">
                                    <li><strong>{{translate('Commission Mode')}}:</strong>&nbsp;{{ $provider->independent_mode ? translate('Independent') : translate('Standard') }}</li>
                                    @if($provider->independent_mode)
                                        <li><strong>{{translate('Admin Commission')}}:</strong>&nbsp;{{ number_format((float)$provider->admin_commission_percent, 2) }}%</li>
                                        <li><strong>{{translate('Provider Commission')}}:</strong>&nbsp;{{ number_format((float)$provider->provider_commission_percent, 2) }}%</li>
                                        <li><strong>{{translate('Payment Fee')}}:</strong>&nbsp;{{ with_currency_symbol($provider->platform_fee_amount ?? 0) }} {{ $provider->platform_fee_label ?: '' }}</li>
                                        <li><strong>{{translate('Tax')}}:</strong>&nbsp;{{ $provider->tax_percent === null ? translate('Service_tax_setting') : number_format((float)$provider->tax_percent, 2).'%' }}</li>
                                        <li><strong>{{translate('Booking Fee')}}:</strong>&nbsp;{{ with_currency_symbol($provider->booking_fee ?? 0) }} {{ $provider->booking_fee_label ?: '' }}</li>
                                        <li><strong>{{translate('Custom Extra Charges')}}:</strong>&nbsp;{{ $provider->custom_fees_enabled ? translate('Enabled') : translate('Disabled') }}</li>
                                        @foreach(providerChargeTypes() as $chargeKey => $chargeMeta)
                                            @php $chargeOwner = $extraChargeOwners[$chargeKey] ?? $chargeMeta['default']; @endphp
                                            <li><strong>{{translate($chargeMeta['label'])}}:</strong>&nbsp;{{ translate($chargeOwnerLabels[$chargeOwner] ?? ucfirst((string)$chargeOwner)) }}</li>
                                        @endforeach
                                        <li><strong>{{translate('Allowed Payment Methods')}}:</strong>&nbsp;{{ $allowedPaymentMethods ? implode(', ', array_map(fn($method) => translate(ucfirst((string)$method)), $allowedPaymentMethods)) : translate('Not_Configured') }}</li>
                                    @else
                                        <li><span class="text-muted">{{translate('Standard_commission_and_subscription_settings_apply')}}</span></li>
                                        <li><strong>{{translate('Provider Commission')}}:</strong>&nbsp;{{ $provider->commission_status ? number_format((float)$provider->commission_percentage, 2).'%' : translate('Global_Default') }}</li>
                                    @endif
                                    <li><strong>{{translate('Can Create Services')}}:</strong>&nbsp;{{ $provider->allow_service_create ? translate('Yes') : translate('No') }}</li>
                                    <li><strong>{{translate('Can Edit Services')}}:</strong>&nbsp;{{ $provider->allow_service_edit ? translate('Yes') : translate('No') }}</li>
                                    <li><strong>{{translate('Service Approval Required')}}:</strong>&nbsp;{{ $provider->service_approval_required ? translate('Yes') : translate('No') }}</li>
                                    <li><strong>{{translate('Calling')}}:</strong>&nbsp;{{ $provider->calling_enabled ? translate('Enabled') : translate('Disabled') }}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script')

    <script src="{{asset('public/assets/provider-module')}}/plugins/apex/apexcharts.min.js"></script>

    <script>
        "use strict";

        var options = {
            labels: ['accepted', 'ongoing', 'completed', 'canceled'],
            series: {{json_encode($total)}},
            chart: {
                width: 235,
                height: 160,
                type: 'donut',
            },
            dataLabels: {
                enabled: false
            },
            title: {
                text: "{{$provider->bookings_count}} Bookings",
                align: 'center',
                offsetX: 0,
                offsetY: 58,
                floating: true,
                style: {
                    fontSize: '12px',
                    fontWeight: 600,
                },
            },
            responsive: [{
                breakpoint: 480,
                options: {
                    legend: {
                        show: true
                    }
                }
            }],
            legend: {
                position: 'bottom',
                offsetY: -5,
                height: 30,
            },
        };

        var chart = new ApexCharts(document.querySelector("#apex-pie-chart"), options);
        chart.render();

        $('.provider_approval').on('click', function () {
            let itemId = $(this).data('approve');
            let route = '{{ route('admin.provider.update-approval', ['id' => ':itemId', 'status' => 'deny']) }}';
            route = route.replace(':itemId', itemId);
            route_alert_reload(route, '{{ translate('want_to_deny_the_provider') }}');
        });

        $('.approval_provider').on('click', function () {
            let itemId = $(this).data('approve');
            let route = '{{ route('admin.provider.update-approval', ['id' => ':itemId', 'status' => 'approve']) }}';
            route = route.replace(':itemId', itemId);
            route_alert_reload(route, '{{ translate('want_to_approve_the_provider') }}');
        });
    </script>
@endpush

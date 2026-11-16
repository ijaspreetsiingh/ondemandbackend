@extends('adminmodule::layouts.master')

@section('title',translate('Provider_Pending_Amount_Collect'))

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="page-title-wrap mb-3">
                <h2 class="page-title">{{translate('Provider_Pending_Amount_Collect')}}</h2>
                <p class="text-muted mb-0">
                    {{translate('provider_pending_collection_hint')}}
                </p>
            </div>

            <div class="row mb-4 g-4">
                <div class="col-lg-4 col-sm-6">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <h3 class="mb-1">{{with_currency_symbol($totalPending)}}</h3>
                                <p class="text-muted mb-0">{{translate('Total_Pending_Amount')}}</p>
                            </div>
                            <span class="material-icons fs-1 text-warning">account_balance_wallet</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <h3 class="mb-1">{{$providers->total()}}</h3>
                                <p class="text-muted mb-0">{{translate('Providers')}}</p>
                            </div>
                            <span class="material-icons fs-1 text-primary">engineering</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <h3 class="mb-1">{{$threshold}} {{translate('Days')}}</h3>
                                <p class="text-muted mb-0">{{translate('Overdue_Threshold')}}</p>
                            </div>
                            <span class="material-icons fs-1 text-danger">schedule</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <div class="data-table-top d-flex flex-wrap gap-10 justify-content-between align-items-center">
                        <div class="d-flex flex-wrap gap-2">
                            <a href="{{route('admin.provider.pending_collection.index')}}"
                               class="btn btn-sm {{!$showAll ? 'btn--primary' : 'btn-outline-primary'}}">
                                {{translate('Pending_Only')}}
                            </a>
                            <a href="{{route('admin.provider.pending_collection.index', ['filter' => 'all'])}}"
                               class="btn btn-sm {{$showAll ? 'btn--primary' : 'btn-outline-primary'}}">
                                {{translate('All_Providers')}}
                            </a>
                        </div>

                        <form action="{{route('admin.provider.pending_collection.index')}}"
                              class="search-form search-form_style-two d-flex gap-2" method="GET">
                            <input type="hidden" name="filter" value="{{$showAll ? 'all' : ''}}">
                            <div class="input-group search-form__input_group">
                                <span class="search-form__icon">
                                    <span class="material-icons">search</span>
                                </span>
                                <input type="search" class="theme-input-style search-form__input"
                                       value="{{$search}}" name="search"
                                       placeholder="{{translate('search_by_provider_name_or_id')}}">
                            </div>
                            <button type="submit" class="btn btn--primary">{{translate('search')}}</button>
                        </form>
                    </div>

                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead>
                            <tr>
                                <th>{{translate('SL')}}</th>
                                <th>{{translate('Provider')}}</th>
                                <th>{{translate('Service_Men')}}</th>
                                <th>{{translate('Total_Bookings')}}</th>
                                <th>{{translate('Completed')}}</th>
                                <th>{{translate('Pending_Amount')}}</th>
                                <th>{{translate('Pending_Since')}}</th>
                                <th>{{translate('Action')}}</th>
                            </tr>
                            </thead>
                            <tbody>
                            @forelse($providers as $key => $provider)
                                @php
                                    $stat = $stats[$provider->id] ?? [];
                                    $pending = (float) ($provider->owner?->account?->account_payable ?? 0);
                                    $overdueDays = (int) ($stat['overdue_days'] ?? 0);
                                    $isOverdue = $pending > 0 && $overdueDays >= $threshold;
                                @endphp
                                <tr style="{{$isOverdue ? 'box-shadow: inset 4px 0 0 0 #dc3545; background-color: rgba(220,53,69,.05);' : ''}}">
                                    <td>{{$providers->firstItem() + $key}}</td>
                                    <td>
                                        <div class="d-flex flex-column">
                                            <span class="fw-semibold">{{$provider->company_name}}</span>
                                            <small class="text-muted">{{$provider->owner?->first_name}} {{$provider->owner?->last_name}}</small>
                                            <small class="text-muted">{{$provider->owner?->phone}}</small>
                                        </div>
                                    </td>
                                    <td>{{$stat['servicemen'] ?? 0}}</td>
                                    <td>{{$stat['total_bookings'] ?? 0}}</td>
                                    <td>{{$stat['completed_bookings'] ?? 0}}</td>
                                    <td>
                                        <span class="fw-bold {{$pending > 0 ? 'text-danger' : 'text-success'}}">
                                            {{with_currency_symbol($pending)}}
                                        </span>
                                    </td>
                                    <td>
                                        @if($pending > 0 && !empty($stat['pending_since']))
                                            {{$stat['pending_since']->format('d M, Y')}}
                                            @if($isOverdue)
                                                <span class="badge bg-danger ms-1">{{$overdueDays}} {{translate('days')}}</span>
                                            @endif
                                        @else
                                            -
                                        @endif
                                    </td>
                                    <td>
                                        <a href="{{route('admin.provider.pending_collection.show', [$provider->id])}}"
                                           class="btn btn-sm btn--primary">
                                            {{translate('View')}}
                                        </a>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="8" class="text-center py-5">
                                        <div class="text-muted">
                                            <span class="material-icons fs-1 d-block mb-2">inbox</span>
                                            {{translate('No_pending_amount_found')}}
                                        </div>
                                    </td>
                                </tr>
                            @endforelse
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex justify-content-end">
                        {!! $providers->links() !!}
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

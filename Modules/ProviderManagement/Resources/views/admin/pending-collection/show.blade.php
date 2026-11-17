@extends('adminmodule::layouts.master')

@section('title',translate('Provider_Pending_Amount'))

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="page-title-wrap mb-3 d-flex flex-wrap justify-content-between align-items-center gap-2">
                <div>
                    <h2 class="page-title mb-1">{{$provider->company_name}}</h2>
                    <p class="text-muted mb-0">
                        {{$provider->owner?->first_name}} {{$provider->owner?->last_name}}
                        &middot; {{$provider->owner?->phone}}
                        &middot; {{$provider->zone?->name}}
                    </p>
                </div>
                <a href="{{route('admin.provider.pending_collection.index')}}" class="btn btn--secondary btn-sm">
                    <span class="material-icons align-middle">arrow_back</span>
                    {{translate('Back')}}
                </a>
            </div>

            <div class="card mb-4">
                <div class="card-body">
                    <form action="{{route('admin.provider.pending_collection.show', [$provider->id])}}" method="GET"
                          class="d-flex flex-wrap gap-3 align-items-end">
                        <div>
                            <label class="form-label mb-1">{{translate('From')}}</label>
                            <input type="date" class="form-control" name="from" value="{{request('from')}}">
                        </div>
                        <div>
                            <label class="form-label mb-1">{{translate('To')}}</label>
                            <input type="date" class="form-control" name="to" value="{{request('to')}}">
                        </div>
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn--primary">{{translate('Filter')}}</button>
                            @if(request('from') || request('to'))
                                <a href="{{route('admin.provider.pending_collection.show', [$provider->id])}}"
                                   class="btn btn--secondary">{{translate('Reset')}}</a>
                            @endif
                        </div>
                    </form>
                </div>
            </div>

            @if($pendingAmount > 0 && $overdueDays >= $threshold)
                <div class="alert alert-danger d-flex align-items-center gap-2" role="alert">
                    <span class="material-icons">warning</span>
                    <span>
                        {{translate('provider_pending_overdue_notice')}} {{$overdueDays}} {{translate('days')}}
                        ({{translate('Threshold')}}: {{$threshold}} {{translate('days')}}).
                    </span>
                </div>
            @endif

            <div class="row mb-4 g-4">
                <div class="col-lg-3 col-sm-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h3 class="mb-1 text-danger">{{with_currency_symbol($pendingAmount)}}</h3>
                            <p class="text-muted mb-0">{{translate('Pending_Amount')}}</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h3 class="mb-1">{{with_currency_symbol($totalServicemanPending)}}</h3>
                            <p class="text-muted mb-0">{{translate('Service_Men_Pending')}}</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h3 class="mb-1">{{$bookingStats->sum()}}</h3>
                            <p class="text-muted mb-0">
                                {{translate('Total_Bookings')}}
                                ({{translate('completed')}}: {{$bookingStats['completed'] ?? 0}})
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h3 class="mb-1">
                                {{round((float) ($reviewSummary->average ?? 0), 1)}}
                                <small class="text-muted fs-6">/ 5</small>
                            </h3>
                            <p class="text-muted mb-0">
                                {{translate('Reviews')}} ({{(int) ($reviewSummary->total ?? 0)}})
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-body p-30">
                    <h5 class="mb-3">{{translate('Collect_Pending_Amount')}}</h5>
                    <form action="{{route('admin.provider.pending_collection.collect')}}" method="POST">
                        @csrf
                        <div class="row g-4 align-items-end">
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input type="number" class="form-control" name="amount"
                                           min="1" step="any" max="{{$pendingAmount}}"
                                           placeholder="{{translate('Amount')}}" required
                                           {{$pendingAmount <= 0 ? 'disabled' : ''}}>
                                    <input type="hidden" name="provider_id" value="{{$provider->id}}">
                                    <label>{{translate('Amount_*')}}</label>
                                </div>
                                <small class="text-muted">
                                    {{translate('Max')}}: {{with_currency_symbol($pendingAmount)}}
                                </small>
                            </div>
                            <div class="col-md-3">
                                @can('provider_update')
                                    <button type="submit" class="btn btn--primary w-100"
                                            {{$pendingAmount <= 0 ? 'disabled' : ''}}>
                                        {{translate('Collect')}}
                                    </button>
                                @endcan
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="mb-3">{{translate('Service_Men_Pending_Details')}}</h5>
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead>
                            <tr>
                                <th>{{translate('SL')}}</th>
                                <th>{{translate('Service_Man')}}</th>
                                <th>{{translate('Total_Bookings')}}</th>
                                <th>{{translate('Completed')}}</th>
                                <th>{{translate('Earning_Amount')}}</th>
                                <th>{{translate('Due_Amount')}}</th>
                                <th>{{translate('Collected_Amount')}}</th>
                                <th>{{translate('Pending_Amount')}}</th>
                                <th>{{translate('Reviews')}}</th>
                                <th>{{translate('Status')}}</th>
                            </tr>
                            </thead>
                            <tbody>
                            @forelse($servicemen as $key => $serviceman)
                                <tr style="{{$serviceman['is_overdue'] ? 'box-shadow: inset 4px 0 0 0 #dc3545; background-color: rgba(220,53,69,.05);' : ''}}">
                                    <td>{{$key + 1}}</td>
                                    <td>
                                        <div class="d-flex flex-column">
                                            <span class="fw-semibold">{{$serviceman['name']}}</span>
                                            <small class="text-muted">{{$serviceman['phone']}}</small>
                                        </div>
                                    </td>
                                    <td>{{$serviceman['total_bookings']}}</td>
                                    <td>{{$serviceman['completed_bookings']}}</td>
                                    <td>{{with_currency_symbol($serviceman['earning_amount'])}}</td>
                                    <td>{{with_currency_symbol($serviceman['due_amount'])}}</td>
                                    <td class="text-success">{{with_currency_symbol($serviceman['collected_amount'])}}</td>
                                    <td>
                                        <span class="fw-bold {{$serviceman['pending_amount'] > 0 ? 'text-danger' : 'text-success'}}">
                                            {{with_currency_symbol($serviceman['pending_amount'])}}
                                        </span>
                                    </td>
                                    <td>
                                        @if($serviceman['total_reviews'] > 0)
                                            <span class="badge bg-warning text-dark">
                                                {{$serviceman['average_rating']}} ★ ({{$serviceman['total_reviews']}})
                                            </span>
                                        @else
                                            <span class="text-muted">-</span>
                                        @endif
                                    </td>
                                    <td>
                                        @if($serviceman['pending_amount'] <= 0)
                                            <span class="badge bg-success">{{translate('Clear')}}</span>
                                        @elseif($serviceman['is_overdue'])
                                            <span class="badge bg-danger">
                                                {{$serviceman['overdue_days']}} {{translate('days_overdue')}}
                                            </span>
                                        @else
                                            <span class="badge bg-warning text-dark">{{translate('Pending')}}</span>
                                        @endif
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="10" class="text-center py-5 text-muted">
                                        {{translate('No_service_man_found')}}
                                    </td>
                                </tr>
                            @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-xl-6"><div class="card h-100"><div class="card-body">
                    <h5 class="mb-3">{{translate('Provider_Payments_Received')}}</h5>
                    <div class="table-responsive"><table class="table align-middle">
                        <thead><tr><th>{{translate('Date')}}</th><th>{{translate('Amount')}}</th><th>{{translate('Transaction_ID')}}</th></tr></thead>
                        <tbody>
                        @forelse($providerPayments as $payment)
                            <tr><td>{{\Carbon\Carbon::parse($payment->created_at)->format('d M, Y h:i A')}}</td>
                                <td class="text-success fw-semibold">{{with_currency_symbol($payment->amount)}}</td><td><small>{{$payment->id}}</small></td></tr>
                        @empty
                            <tr><td colspan="3" class="text-center text-muted py-4">{{translate('No_payment_found')}}</td></tr>
                        @endforelse
                        </tbody>
                    </table></div>
                </div></div></div>
                <div class="col-xl-6"><div class="card h-100"><div class="card-body">
                    <h5 class="mb-3">{{translate('Service_Man_Collections')}}</h5>
                    <div class="table-responsive"><table class="table align-middle">
                        <thead><tr><th>{{translate('Service_Man')}}</th><th>{{translate('Date')}}</th><th>{{translate('Amount')}}</th><th>{{translate('Note')}}</th></tr></thead>
                        <tbody>
                        @forelse($servicemanCollections as $collection)
                            <tr><td>{{trim(($collection->first_name ?? '') . ' ' . ($collection->last_name ?? ''))}}</td>
                                <td>{{\Carbon\Carbon::parse($collection->created_at)->format('d M, Y h:i A')}}</td>
                                <td class="text-success fw-semibold">{{with_currency_symbol($collection->amount)}}</td>
                                <td>{{$collection->note ?: '-'}}</td></tr>
                        @empty
                            <tr><td colspan="4" class="text-center text-muted py-4">{{translate('No_payment_found')}}</td></tr>
                        @endforelse
                        </tbody>
                    </table></div>
                </div></div></div>
            </div>

            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="mb-3">{{translate('Booking_Settlement_Details')}}</h5>
                    <div class="table-responsive"><table class="table align-middle">
                        <thead><tr><th>{{translate('Booking')}}</th><th>{{translate('Date')}}</th>
                            <th>{{translate('Service_Name')}}</th><th>{{translate('Service_Man')}}</th>
                            <th>{{translate('Customer_Paid')}}</th><th>{{translate('Admin_Commission')}}</th>
                            <th>{{translate('Provider_Commission')}}</th><th>{{translate('Service_Man_Earning')}}</th>
                            <th>{{translate('Service_Man_Paid_to_Provider')}}</th><th>{{translate('Extra_Fee')}}</th><th>{{translate('Tax')}}</th></tr></thead>
                        <tbody>
                        @forelse($bookingLedgers as $booking)
                            <tr><td><a href="{{route('admin.booking.details', [$booking->id, 'web_page' => 'details'])}}">#{{$booking->readable_id}}</a></td>
                                <td>{{\Carbon\Carbon::parse($booking->created_at)->format('d M, Y')}}</td>
                                <td>{{$booking->sub_category_name ?: ($booking->category_name ?: '-')}}</td>
                                <td>{{trim(($booking->serviceman_first_name ?? '') . ' ' . ($booking->serviceman_last_name ?? '')) ?: '-'}}</td>
                                <td>{{with_currency_symbol($booking->total_booking_amount)}}</td>
                                <td>{{with_currency_symbol($booking->admin_share)}}</td>
                                <td>{{with_currency_symbol($booking->provider_share)}}</td>
                                <td>{{with_currency_symbol($booking->serviceman_earning)}}</td>
                                <td>{{with_currency_symbol($booking->serviceman_collected)}}
                                    @if(count($booking->serviceman_payment_history))
                                        <details><summary>{{translate('Payment_History')}}</summary>
                                            @foreach($booking->serviceman_payment_history as $receipt)
                                                <div class="small text-nowrap">
                                                    {{with_currency_symbol($receipt['amount'])}}
                                                    · {{\Carbon\Carbon::parse($receipt['created_at'])->format('d M, Y h:i A')}}
                                                    @if(!empty($receipt['note'])) · {{$receipt['note']}} @endif
                                                </div>
                                            @endforeach
                                        </details>
                                    @endif
                                </td>
                                <td>{{with_currency_symbol($booking->extra_fee)}}</td>
                                <td>{{with_currency_symbol($booking->total_tax_amount)}}</td></tr>
                        @empty
                            <tr><td colspan="11" class="text-center py-5 text-muted">{{translate('No_booking_found')}}</td></tr>
                        @endforelse
                        </tbody>
                    </table></div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="mb-3">{{translate('Services')}}</h5>
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead>
                            <tr>
                                <th>{{translate('SL')}}</th>
                                <th>{{translate('Service_Name')}}</th>
                                <th>{{translate('Category')}}</th>
                                <th>{{translate('Total_Bookings')}}</th>
                                <th>{{translate('Completed')}}</th>
                            </tr>
                            </thead>
                            <tbody>
                            @forelse($services as $key => $service)
                                <tr>
                                    <td>{{$key + 1}}</td>
                                    <td class="fw-semibold">{{$service->service_name}}</td>
                                    <td>{{$service->category_name}}</td>
                                    <td>{{$service->total}}</td>
                                    <td>{{$service->completed}}</td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        {{translate('No_service_found')}}
                                    </td>
                                </tr>
                            @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <h5 class="mb-3">{{translate('Recent_Reviews')}}</h5>
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead>
                            <tr>
                                <th>{{translate('Service_Man')}}</th>
                                <th>{{translate('Rating')}}</th>
                                <th>{{translate('Comment')}}</th>
                                <th>{{translate('Date')}}</th>
                            </tr>
                            </thead>
                            <tbody>
                            @forelse($reviews as $review)
                                <tr>
                                    <td>{{trim(($review->serviceman_first_name ?? '') . ' ' . ($review->serviceman_last_name ?? '')) ?: '-'}}</td>
                                    <td>{{$review->review_rating}} ★</td>
                                    <td>{{Str::limit($review->review_comment, 80)}}</td>
                                    <td>{{\Carbon\Carbon::parse($review->created_at)->format('d M, Y')}}</td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        {{translate('No_review_found')}}
                                    </td>
                                </tr>
                            @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

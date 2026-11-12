<?php

namespace Modules\ProviderManagement\Http\Middleware;

use Brian2694\Toastr\Facades\Toastr;
use Closure;
use Illuminate\Http\Request;

class ProviderMiddleware
{
    /**
     * Handle an incoming request.
     *
     * Provider portal abhi band hai — sirf admin hi portal me login kar sakta
     * hai. Provider ka koi bhi web route (dashboard, bookings, wallet, reports)
     * admin login par redirect ho jata hai. Provider app ki API functionality
     * par iska koi asar nahi hai.
     *
     * @param Request $request
     * @param Closure $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        Toastr::info(translate('Provider panel is currently disabled. Please use the admin panel.'));
        return redirect()->route('admin.auth.login');
    }
}

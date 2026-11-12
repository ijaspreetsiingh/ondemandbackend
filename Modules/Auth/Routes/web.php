<?php

use Illuminate\Support\Facades\Route;
use Modules\Auth\Http\Controllers\LoginController;
use Modules\Auth\Http\Controllers\RegisterController;

Route::group(['prefix' => 'admin', 'as' => 'admin.', 'middleware' => ['actch:admin_panel']], function () {
    Route::group(['prefix' => 'auth', 'as' => 'auth.'], function () {
        Route::get('login', [LoginController::class, 'loginForm'])->name('login');
        Route::post('login', [LoginController::class, 'adminLogin'])->middleware('throttle:login');
        Route::get('logout', [LoginController::class, 'logout'])->name('logout');
    });
});

Route::group(['prefix' => 'provider', 'as' => 'provider.'], function () {
    /**
     * Provider portal yahan se band hai.
     *
     * Provider ka login / sign-up / password-reset / verification ab portal me
     * nahi chalega. Route names yahin register rehte hain (mail templates aur
     * purane links `route('provider.auth.login')` use karte hain) lekin har
     * request admin login par redirect ho jati hai. Provider app ki API
     * functionality is se bilkul untouched hai.
     */
    Route::group(['prefix' => 'auth', 'as' => 'auth.'], function () {
        /**
         * Redirect routes (closure nahi) — warna `php artisan optimize` /
         * `route:cache` "Unable to prepare route ... Uses Closure" par fail
         * ho jata hai aur deploy adhoora reh jata hai.
         */
        $adminLogin = '/admin/auth/login';

        Route::redirect('sign-up', $adminLogin)->name('sign-up');
        Route::redirect('sign-up-submit', $adminLogin)->name('sign-up-submit');
        Route::redirect('login', $adminLogin)->name('login');
        Route::redirect('logout', $adminLogin)->name('logout');

        Route::group(['prefix' => 'reset-password', 'as' => 'reset-password.'], function () use ($adminLogin) {
            Route::redirect('/', $adminLogin)->name('index');
            Route::redirect('send-otp', $adminLogin)->name('send-otp');
            Route::redirect('verify-otp', $adminLogin)->name('verify-otp');
            Route::redirect('change-password', $adminLogin)->name('change-password');
        });

        Route::group(['prefix' => 'verification', 'as' => 'verification.'], function () use ($adminLogin) {
            Route::redirect('/', $adminLogin)->name('index');
            Route::redirect('send-otp', $adminLogin)->name('send-otp');
            Route::redirect('verify-otp', $adminLogin)->name('verify-otp');
        });
    });

});

Route::group(['prefix' => 'serviceman', 'as' => 'serviceman.'], function () {
    Route::group(['prefix' => 'auth', 'as' => 'auth.'], function () {
        Route::get('login', [LoginController::class, 'servicemanLoginForm'])->name('login');
        Route::post('login', [LoginController::class, 'servicemanPanelLogin'])->middleware('throttle:login');
        Route::get('logout', [LoginController::class, 'logout'])->name('logout');
    });
});

Route::post('check-unique-user', [RegisterController::class, 'checkUniqueUser'])->name('check-unique-user');

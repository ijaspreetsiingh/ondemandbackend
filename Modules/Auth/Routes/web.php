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
        $toAdminLogin = fn () => redirect()->route('admin.auth.login');

        Route::any('sign-up', $toAdminLogin)->name('sign-up');
        Route::any('sign-up-submit', $toAdminLogin)->name('sign-up-submit');
        Route::any('login', $toAdminLogin)->name('login');
        Route::any('logout', $toAdminLogin)->name('logout');

        Route::group(['prefix' => 'reset-password', 'as' => 'reset-password.'], function () use ($toAdminLogin) {
            Route::any('/', $toAdminLogin)->name('index');
            Route::any('send-otp', $toAdminLogin)->name('send-otp');
            Route::any('verify-otp', $toAdminLogin)->name('verify-otp');
            Route::any('change-password', $toAdminLogin)->name('change-password');
        });

        Route::group(['prefix' => 'verification', 'as' => 'verification.'], function () use ($toAdminLogin) {
            Route::any('/', $toAdminLogin)->name('index');
            Route::any('send-otp', $toAdminLogin)->name('send-otp');
            Route::any('verify-otp', $toAdminLogin)->name('verify-otp');
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

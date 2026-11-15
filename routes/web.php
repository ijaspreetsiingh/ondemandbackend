<?php

use App\Http\Controllers\BecomeAProviderController;
use App\Http\Controllers\LandingController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\InstallController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('lang/{locale}', [LandingController::class, 'lang'])->name('lang');

// Customer web app is the site's landing page (the old static landing lives at /landing).
Route::get('/', function () {
    return response()->file(public_path('web-app/index.html'), [
        'Cache-Control' => 'no-store, max-age=0',
        'Content-Type' => 'text/html; charset=UTF-8',
    ]);
})->name('home');
Route::get('page/contact-us', [LandingController::class, 'contactUs'])->name('page.contact-us');

Route::get('business-page/{slug}', [LandingController::class, 'dynamicPage'])->name('business.page.dynamic');

Route::get('maintenance-mode', [LandingController::class, 'maintenanceMode'])->name('maintenance-mode');

// Landing page: "Become a Provider" - request form (admin approval ke baad ID banegi)
Route::get('page/become-a-provider', [BecomeAProviderController::class, 'index'])->name('page.become-a-provider');
Route::post('page/become-a-provider', [BecomeAProviderController::class, 'submit'])->name('page.become-a-provider.submit');
Route::post('subscribe-newsletter',[LandingController::class, 'subscribeNewsletter'])->name('subscribe-newsletter');

Route::fallback(function () {
    return redirect('admin/auth/login');
});

Route::get('test', function () {
    //
});




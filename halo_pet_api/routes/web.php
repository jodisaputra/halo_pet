<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\HospitalWebController;
use App\Http\Controllers\Web\ShopWebController;
use App\Http\Controllers\Web\DoctorWebController;
use App\Http\Controllers\AppointmentValidationController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('auth/login');
});

Auth::routes([
    'register' => false,
]);

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

Route::resource('hospitals', HospitalWebController::class)->middleware('auth');
Route::resource('shops', ShopWebController::class)->middleware('auth');
Route::resource('doctors', DoctorWebController::class)->middleware('auth');

Route::post('doctors/{doctor}/time-slots', [App\Http\Controllers\Web\DoctorWebController::class, 'addTimeSlot'])->middleware('auth');
Route::delete('doctors/{doctor}/time-slots/{slot}', [App\Http\Controllers\Web\DoctorWebController::class, 'deleteTimeSlot'])->middleware('auth');

Route::middleware(['auth'])->group(function () {
    // Appointment Validation Routes
    Route::get('/appointments/validate', [AppointmentValidationController::class, 'index'])
        ->name('appointments.validate');
    Route::put('/appointments/validate/{appointment}', [AppointmentValidationController::class, 'updateStatus'])
        ->name('appointments.validate.update');
});

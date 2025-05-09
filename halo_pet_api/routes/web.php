<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\HospitalWebController;
use App\Http\Controllers\Web\ShopWebController;
use App\Http\Controllers\Web\DoctorWebController;

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
    return view('welcome');
});

Auth::routes([
    'register' => false,
]);

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

Route::resource('hospitals', HospitalWebController::class)->middleware('auth');
Route::resource('shops', ShopWebController::class)->middleware('auth');
Route::resource('doctors', DoctorWebController::class)->middleware('auth');

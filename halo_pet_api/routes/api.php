<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\HospitalController;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\AppointmentController;
use App\Http\Controllers\TimeSlotController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    $user = $request->user();
    return [
        'id' => $user->id,
        'first_name' => $user->first_name,
        'last_name' => $user->last_name,
        'email' => $user->email,
        'profile_image' => $user->profile_image_url,
        'phone' => $user->phone,
        'gender' => $user->gender,
        'dob' => $user->dob,
    ];
});

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/google-login', [AuthController::class, 'googleLogin']);

Route::middleware('auth:api')->post('/user/profile', [AuthController::class, 'updateProfile']);

Route::middleware('api')->group(function () {
    // Hospital routes
    Route::get('/hospitals', [HospitalController::class, 'index']);
    // Shop routes
    Route::get('/shops', [ShopController::class, 'index']);
    // Doctor routes
    Route::get('/doctors', [DoctorController::class, 'index']);
    Route::get('/doctors/{id}', [DoctorController::class, 'show']);
    Route::get('/doctors/{doctor}/available-time-slots', [DoctorController::class, 'availableTimeSlots']);
    
    // Time slot routes (public)
    Route::get('/time-slots', [TimeSlotController::class, 'index']);
    Route::get('/time-slots/{id}', [TimeSlotController::class, 'show']);
    Route::get('/appointments/available-slots', [TimeSlotController::class, 'getAvailableTimeSlots']);
    
    // Protected routes
    Route::middleware('auth:api')->group(function () {
        // Time slot management (admin only)
        Route::middleware('role:admin')->group(function () {
            Route::post('/time-slots', [TimeSlotController::class, 'store']);
            Route::post('/time-slots/bulk', [TimeSlotController::class, 'bulkCreate']);
            Route::put('/time-slots/{id}', [TimeSlotController::class, 'update']);
            Route::delete('/time-slots/{id}', [TimeSlotController::class, 'destroy']);
        });

        // Appointment routes
        Route::get('/appointments', [AppointmentController::class, 'index']);
        Route::post('/appointments', [AppointmentController::class, 'store']);
        Route::get('/appointments/{id}', [AppointmentController::class, 'show']);
        Route::put('/appointments/{id}', [AppointmentController::class, 'update']);
        Route::delete('/appointments/{id}', [AppointmentController::class, 'destroy']);
    });
});

Route::post('/test-log', function () {
    \Log::info('Test log route hit');
    return response()->json(['message' => 'Logged!']);
});

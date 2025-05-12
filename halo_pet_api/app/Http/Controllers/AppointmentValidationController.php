<?php

namespace App\Http\Controllers;

use App\Models\Appointment;
use Illuminate\Http\Request;

class AppointmentValidationController extends Controller
{
    public function index()
    {
        $appointments = Appointment::with(['user', 'doctor'])
            ->orderBy('appointment_date', 'desc')
            ->orderBy('appointment_time', 'desc')
            ->get();

        return view('appointments.validate', compact('appointments'));
    }

    public function updateStatus(Request $request, Appointment $appointment)
    {
        $request->validate([
            'status' => 'required|in:confirmed,cancelled'
        ]);

        $appointment->update([
            'status' => $request->status
        ]);

        return redirect()->route('appointments.validate')
            ->with('success', 'Appointment status updated successfully.');
    }
} 
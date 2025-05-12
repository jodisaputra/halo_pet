<?php

namespace App\Http\Controllers;

use App\Models\Appointment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;

class AppointmentController extends Controller
{
    public function index(Request $request)
    {
        $query = Appointment::with(['user', 'doctor'])
            ->where('user_id', $request->user()->id);

        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        $appointments = $query->orderBy('appointment_date')
            ->orderBy('appointment_time')
            ->get();

        return response()->json($appointments);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'doctor_id' => 'required|exists:doctors,id',
            'appointment_date' => 'required|date|after_or_equal:today',
            'appointment_time' => 'required|date_format:H:i',
            'notes' => 'nullable|string'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Check if the doctor is available at the requested time
        $existingAppointment = Appointment::where('doctor_id', $request->doctor_id)
            ->where('appointment_date', $request->appointment_date)
            ->where('appointment_time', $request->appointment_time)
            ->where('status', '!=', 'cancelled')
            ->exists();

        if ($existingAppointment) {
            return response()->json([
                'message' => 'The selected time slot for this doctor is already booked. Please choose a different time.'
            ], 422);
        }

        // Check if user already has an appointment on the same day
        $userAppointment = Appointment::where('user_id', $request->user()->id)
            ->where('appointment_date', $request->appointment_date)
            ->where('status', '!=', 'cancelled')
            ->exists();

        if ($userAppointment) {
            return response()->json([
                'message' => 'You already have an appointment scheduled for this day.'
            ], 422);
        }

        $appointment = Appointment::create([
            'user_id' => $request->user()->id,
            'doctor_id' => $request->doctor_id,
            'appointment_date' => $request->appointment_date,
            'appointment_time' => $request->appointment_time,
            'notes' => $request->notes,
            'status' => 'pending'
        ]);

        return response()->json($appointment, 201);
    }

    public function show($id)
    {
        $appointment = Appointment::with(['user', 'doctor'])
            ->findOrFail($id);
        return response()->json($appointment);
    }

    public function update(Request $request, $id)
    {
        $appointment = Appointment::findOrFail($id);

        // Only allow users to update their own appointments
        if ($appointment->user_id !== $request->user()->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validator = Validator::make($request->all(), [
            'appointment_date' => 'sometimes|required|date|after_or_equal:today',
            'appointment_time' => 'sometimes|required|date_format:H:i',
            'status' => 'sometimes|required|in:pending,confirmed,cancelled,completed',
            'notes' => 'nullable|string'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // If date or time is being changed, check for conflicts
        if ($request->has('appointment_date') || $request->has('appointment_time')) {
            $existingAppointment = Appointment::where('doctor_id', $appointment->doctor_id)
                ->where('appointment_date', $request->appointment_date ?? $appointment->appointment_date)
                ->where('appointment_time', $request->appointment_time ?? $appointment->appointment_time)
                ->where('id', '!=', $id)
                ->where('status', '!=', 'cancelled')
                ->exists();

            if ($existingAppointment) {
                return response()->json([
                    'message' => 'This time slot is already booked. Please choose another time.'
                ], 422);
            }
        }

        $appointment->update($request->all());
        return response()->json($appointment);
    }

    public function destroy($id)
    {
        $appointment = Appointment::findOrFail($id);
        $appointment->delete();
        return response()->json(null, 204);
    }

    public function getAvailableTimeSlots(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'doctor_id' => 'required|exists:doctors,id',
            'date' => 'required|date|after_or_equal:today'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Get all booked time slots for the doctor on the given date
        $bookedSlots = Appointment::where('doctor_id', $request->doctor_id)
            ->where('appointment_date', $request->date)
            ->where('status', '!=', 'cancelled')
            ->pluck('appointment_time')
            ->map(function ($time) {
                return Carbon::parse($time)->format('H:i');
            })
            ->toArray();

        // Generate all possible time slots
        $allSlots = [];
        $startTime = Carbon::parse('08:00');
        $endTime = Carbon::parse('19:30');

        while ($startTime->lte($endTime)) {
            $timeSlot = $startTime->format('H:i');
            if (!in_array($timeSlot, $bookedSlots)) {
                $allSlots[] = $timeSlot;
            }
            $startTime->addMinutes(30);
        }

        return response()->json($allSlots);
    }
} 
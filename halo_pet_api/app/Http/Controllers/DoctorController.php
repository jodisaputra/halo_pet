<?php

namespace App\Http\Controllers;

use App\Models\Doctor;
use Illuminate\Http\Request;

class DoctorController extends Controller
{
    // GET /api/doctors?search=keyword
    public function index(Request $request)
    {
        $query = Doctor::query();
        if ($request->has('search') && $request->search) {
            $search = $request->search;
            $query->where(function($q) use ($search) {
                $q->where('name', 'like', "%$search%")
                  ->orWhere('specialty', 'like', "%$search%")
                  ->orWhere('location', 'like', "%$search%")
                  ->orWhere('about', 'like', "%$search%")
                  ->orWhere('working_time', 'like', "%$search%")
                ;
            });
        }
        $doctors = $query->get(['id', 'name', 'specialty', 'image', 'location', 'about', 'working_time']);
        return response()->json($doctors);
    }

    // GET /api/doctors/{id}
    public function show($id)
    {
        $doctor = Doctor::select('id', 'name', 'specialty', 'image', 'location', 'about', 'working_time')->findOrFail($id);
        return response()->json($doctor);
    }

    public function availableTimeSlots($doctorId)
    {
        $doctor = \App\Models\Doctor::with(['timeSlots' => function($query) {
            $query->where('is_available', true);
        }])->findOrFail($doctorId);

        $slots = $doctor->timeSlots->map(function($slot) {
            return [
                'start_time' => $slot->start_time->format('H:i'),
                'end_time' => $slot->end_time->format('H:i'),
            ];
        });

        return response()->json($slots);
    }
}

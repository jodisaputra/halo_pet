<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Doctor;

class DoctorWebController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $doctors = Doctor::all();
        return view('doctors.index', compact('doctors'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('doctors.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required',
            'specialty' => 'required',
            'image' => 'nullable|image',
            'location' => 'nullable',
            'about' => 'nullable',
            'working_time' => 'nullable',
        ]);
        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('doctors', 'public');
            $validated['image'] = $path;
        }
        Doctor::create($validated);
        return redirect()->route('doctors.index')->with('success', 'Doctor created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Doctor $doctor)
    {
        return view('doctors.show', compact('doctor'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Doctor $doctor)
    {
        return view('doctors.edit', compact('doctor'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Doctor $doctor)
    {
        $validated = $request->validate([
            'name' => 'required',
            'specialty' => 'required',
            'image' => 'nullable|image',
            'location' => 'nullable',
            'about' => 'nullable',
            'working_time' => 'nullable',
        ]);
        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('doctors', 'public');
            $validated['image'] = $path;
        }
        $doctor->update($validated);
        return redirect()->route('doctors.index')->with('success', 'Doctor updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

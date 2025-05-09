<?php

namespace App\Http\Controllers;

use App\Models\Hospital;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class HospitalController extends Controller
{
    public function index()
    {
        $hospitals = Hospital::all();
        return response()->json($hospitals);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'address' => 'required|string',
            'phone' => 'required|string',
            'email' => 'required|email',
            'description' => 'required|string',
            'services' => 'required|array',
            'operating_hours' => 'required|array',
            'rating' => 'nullable|numeric|min:0|max:5'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $hospital = Hospital::create($request->all());
        return response()->json($hospital, 201);
    }

    public function show($id)
    {
        $hospital = Hospital::findOrFail($id);
        return response()->json($hospital);
    }

    public function update(Request $request, $id)
    {
        $hospital = Hospital::findOrFail($id);
        
        $validator = Validator::make($request->all(), [
            'name' => 'string|max:255',
            'address' => 'string',
            'phone' => 'string',
            'email' => 'email',
            'description' => 'string',
            'services' => 'array',
            'operating_hours' => 'array',
            'rating' => 'nullable|numeric|min:0|max:5'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $hospital->update($request->all());
        return response()->json($hospital);
    }

    public function destroy($id)
    {
        $hospital = Hospital::findOrFail($id);
        $hospital->delete();
        return response()->json(null, 204);
    }
} 
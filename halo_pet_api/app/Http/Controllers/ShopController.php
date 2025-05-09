<?php

namespace App\Http\Controllers;

use App\Models\Shop;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ShopController extends Controller
{
    public function index()
    {
        $shops = Shop::all();
        return response()->json($shops);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'address' => 'required|string',
            'phone' => 'required|string',
            'email' => 'required|email',
            'description' => 'required|string',
            'operating_hours' => 'required|array',
            'rating' => 'nullable|numeric|min:0|max:5'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $shop = Shop::create($request->all());
        return response()->json($shop, 201);
    }

    public function show($id)
    {
        $shop = Shop::findOrFail($id);
        return response()->json($shop);
    }

    public function update(Request $request, $id)
    {
        $shop = Shop::findOrFail($id);
        
        $validator = Validator::make($request->all(), [
            'name' => 'string|max:255',
            'address' => 'string',
            'phone' => 'string',
            'email' => 'email',
            'description' => 'string',
            'operating_hours' => 'array',
            'rating' => 'nullable|numeric|min:0|max:5'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $shop->update($request->all());
        return response()->json($shop);
    }

    public function destroy($id)
    {
        $shop = Shop::findOrFail($id);
        $shop->delete();
        return response()->json(null, 204);
    }
} 
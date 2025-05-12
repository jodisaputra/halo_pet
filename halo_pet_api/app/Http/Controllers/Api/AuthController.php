<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Password;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            \Log::warning('Register validation failed', $validator->errors()->toArray());
            return response()->json($validator->errors(), 422);
        }

        $user = User::create([
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => 'user',
        ]);

        \Log::info('User registered', ['user_id' => $user->id, 'email' => $user->email]);

        return response()->json([
            'message' => 'User registered successfully',
            'user' => $user
        ], 201);
    }

    public function login(Request $request)
    {
        \Log::info('Login attempt', [
            'email' => $request->email,
            'ip' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'input' => $request->except('password')
        ]);

        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            \Log::warning('Login validation failed', [
                'errors' => $validator->errors()->toArray(),
                'email' => $request->email,
                'ip' => $request->ip()
            ]);
            return response()->json($validator->errors(), 422);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            \Log::warning('Login failed: invalid credentials', [
                'email' => $request->email,
                'ip' => $request->ip()
            ]);
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        $token = $user->createToken('Personal Access Token')->accessToken;

        \Log::info('Login successful', [
            'user_id' => $user->id,
            'email' => $user->email,
            'ip' => $request->ip()
        ]);

        return response()->json([
            'message' => 'Login successful',
            'user' => $user,
            'token' => $token
        ], 200);
    }

    public function forgotPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $status = Password::sendResetLink(
            $request->only('email')
        );

        if ($status === Password::RESET_LINK_SENT) {
            return response()->json(['message' => 'Reset link sent to your email.']);
        } else {
            return response()->json(['message' => 'Unable to send reset link.'], 400);
        }
    }

    public function updateProfile(Request $request)
    {
        try {
            $user = auth()->user();
            if (!$user) {
                return response()->json(['message' => 'Unauthorized'], 401);
            }

            \Log::info('Update Profile Request:', $request->all());

            $validator = Validator::make($request->all(), [
                'first_name' => 'sometimes|string|max:255',
                'last_name' => 'sometimes|string|max:255',
                'phone' => 'nullable|string|max:20',
                'gender' => 'nullable|string|max:20',
                'dob' => 'nullable|date',
                'profile_image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            if ($validator->fails()) {
                \Log::error('Validation failed:', $validator->errors()->toArray());
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            // Handle image upload
            if ($request->hasFile('profile_image')) {
                $image = $request->file('profile_image');
                $imageName = time().'_'.$image->getClientOriginalName();
                $image->move(public_path('profile_images'), $imageName);
                $user->profile_image = 'profile_images/' . $imageName;
            }

            // Define fields array here
            $fields = ['first_name', 'last_name', 'phone', 'gender', 'dob'];
            foreach ($fields as $field) {
                if ($request->filled($field) || $request->has($field)) {
                    \Log::info("Updating $field:", [$request->input($field)]);
                    $user->$field = $request->input($field);
                }
            }
            
            \Log::info('User before save:', $user->toArray());
            $user->save();
            $user->refresh();
            \Log::info('User after save:', $user->toArray());

            return response()->json([
                'message' => 'Profile updated successfully',
                'user' => [
                    'id' => $user->id,
                    'first_name' => $user->first_name,
                    'last_name' => $user->last_name,
                    'email' => $user->email,
                    'profile_image' => $user->profile_image ? url($user->profile_image) : null,
                    'phone' => $user->phone,
                    'gender' => $user->gender,
                    'dob' => $user->dob,
                ]
            ], 200);
        } catch (\Exception $e) {
            \Log::error('Profile update error:', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json([
                'message' => 'Failed to update profile',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

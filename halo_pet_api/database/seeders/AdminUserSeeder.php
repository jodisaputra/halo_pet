<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class AdminUserSeeder extends Seeder
{
    public function run()
    {
        User::updateOrCreate(
            [
                'email' => 'admin@halopet.com',
            ],
            
            [
                'first_name' => 'Admin',
                'last_name' => 'User',
                'password' => Hash::make('admin123'), // Change this password after first login
                'role' => 'admin',
            ]
        );
    }
} 
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Doctor extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'specialty',
        'image',
        'location',
        'about',
        'working_time',
    ];

    public function timeSlots()
    {
        return $this->hasMany(\App\Models\TimeSlot::class);
    }
} 
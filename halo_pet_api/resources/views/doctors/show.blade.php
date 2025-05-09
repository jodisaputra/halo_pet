@extends('layouts.app')

@section('content')
<div class="container">
    <div class="card mx-auto" style="max-width: 500px;">
        <div class="card-body text-center">
            @if($doctor->image)
                <img src="{{ asset('storage/' . $doctor->image) }}" alt="Doctor Image" width="100" height="100" style="object-fit:cover; border-radius:50%; margin-bottom:16px;">
            @else
                <div class="mb-3 text-muted">No Image</div>
            @endif
            <h3 class="card-title">{{ $doctor->name }}</h3>
            <h5 class="card-subtitle mb-2 text-primary">{{ $doctor->specialty }}</h5>
            <p class="mb-1"><strong>Location:</strong> {{ $doctor->location }}</p>
            <p class="mb-1"><strong>About:</strong> {{ $doctor->about }}</p>
            <p class="mb-3"><strong>Working Time:</strong> {{ $doctor->working_time }}</p>
            <a href="{{ route('doctors.edit', $doctor->id) }}" class="btn btn-warning">Edit</a>
            <a href="{{ route('doctors.index') }}" class="btn btn-secondary">Back</a>
        </div>
    </div>
</div>
@endsection 
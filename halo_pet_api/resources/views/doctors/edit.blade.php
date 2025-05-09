@extends('layouts.app')

@section('content')
<div class="container">
    <h2>Edit Doctor</h2>
    <form action="{{ route('doctors.update', $doctor->id) }}" method="POST" enctype="multipart/form-data">
        @csrf
        @method('PUT')
        <div class="form-group mb-3">
            <label for="name">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="{{ $doctor->name }}" required>
        </div>
        <div class="form-group mb-3">
            <label for="specialty">Specialty</label>
            <input type="text" class="form-control" id="specialty" name="specialty" value="{{ $doctor->specialty }}" required>
        </div>
        <div class="form-group mb-3">
            <label for="image">Image</label><br>
            @if($doctor->image)
                <img src="{{ asset('storage/' . $doctor->image) }}" alt="Doctor Image" width="50" height="50" style="object-fit:cover; border-radius:50%; margin-bottom:8px;">
            @endif
            <input type="file" class="form-control" id="image" name="image">
        </div>
        <div class="form-group mb-3">
            <label for="location">Location</label>
            <input type="text" class="form-control" id="location" name="location" value="{{ $doctor->location }}">
        </div>
        <div class="form-group mb-3">
            <label for="about">About</label>
            <textarea class="form-control" id="about" name="about" rows="3">{{ $doctor->about }}</textarea>
        </div>
        <div class="form-group mb-3">
            <label for="working_time">Working Time</label>
            <input type="text" class="form-control" id="working_time" name="working_time" value="{{ $doctor->working_time }}">
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
        <a href="{{ route('doctors.index') }}" class="btn btn-secondary">Cancel</a>
    </form>
</div>
@endsection 
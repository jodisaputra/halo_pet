@extends('layouts.app')

@section('content')
<div class="container">
    <h2>Add Doctor</h2>
    <form action="{{ route('doctors.store') }}" method="POST" enctype="multipart/form-data">
        @csrf
        <div class="form-group mb-3">
            <label for="name">Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="form-group mb-3">
            <label for="specialty">Specialty</label>
            <input type="text" class="form-control" id="specialty" name="specialty" required>
        </div>
        <div class="form-group mb-3">
            <label for="image">Image</label>
            <input type="file" class="form-control" id="image" name="image">
        </div>
        <div class="form-group mb-3">
            <label for="location">Location</label>
            <input type="text" class="form-control" id="location" name="location">
        </div>
        <div class="form-group mb-3">
            <label for="about">About</label>
            <textarea class="form-control" id="about" name="about" rows="3"></textarea>
        </div>
        <div class="form-group mb-3">
            <label for="working_time">Working Time</label>
            <input type="text" class="form-control" id="working_time" name="working_time">
        </div>
        <button type="submit" class="btn btn-primary">Save</button>
        <a href="{{ route('doctors.index') }}" class="btn btn-secondary">Cancel</a>
    </form>
</div>
@endsection 
@extends('layouts.app')

@section('content')
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Doctors</h2>
        <a href="{{ route('doctors.create') }}" class="btn btn-primary">Add Doctor</a>
    </div>
    <table class="table table-bordered bg-white rounded shadow-sm">
        <thead class="thead-light">
            <tr>
                <th>Name</th>
                <th>Specialty</th>
                <th>Image</th>
                <th>Location</th>
                <th>Experience</th>
                <th>Patients</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            @foreach($doctors as $doctor)
            <tr>
                <td>{{ $doctor->name }}</td>
                <td>{{ $doctor->specialty }}</td>
                <td>
                    @if($doctor->image)
                        <img src="{{ asset('storage/' . $doctor->image) }}" alt="Doctor Image" width="50" height="50" style="object-fit:cover; border-radius:50%;">
                    @else
                        <span class="text-muted">No Image</span>
                    @endif
                </td>
                <td>{{ $doctor->location }}</td>
                <td>{{ $doctor->experience }}</td>
                <td>{{ $doctor->patients }}</td>
                <td>
                    <a href="{{ route('doctors.show', $doctor->id) }}" class="btn btn-info btn-sm">Show</a>
                    <a href="{{ route('doctors.edit', $doctor->id) }}" class="btn btn-warning btn-sm">Edit</a>
                    <form action="{{ route('doctors.destroy', $doctor->id) }}" method="POST" style="display:inline-block;">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</button>
                    </form>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection 
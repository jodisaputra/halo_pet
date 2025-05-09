@extends('layouts.app')

@section('content')
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Hospitals</h2>
        <a href="{{ route('hospitals.create') }}" class="btn btn-primary">+ Add Hospital</a>
    </div>
    @if(session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif
    <div class="card shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Email</th>
                        <th>Rating</th>
                        <th style="width: 180px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($hospitals as $hospital)
                        <tr>
                            <td>{{ $hospital->name }}</td>
                            <td>{{ $hospital->address }}</td>
                            <td>{{ $hospital->phone }}</td>
                            <td>{{ $hospital->email }}</td>
                            <td>{{ $hospital->rating }}</td>
                            <td>
                                <a href="{{ route('hospitals.show', $hospital) }}" class="btn btn-info btn-sm me-1">View</a>
                                <a href="{{ route('hospitals.edit', $hospital) }}" class="btn btn-warning btn-sm me-1">Edit</a>
                                <form action="{{ route('hospitals.destroy', $hospital) }}" method="POST" style="display:inline-block">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="6" class="text-center">No hospitals found.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection 
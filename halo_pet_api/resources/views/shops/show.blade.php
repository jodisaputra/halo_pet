@extends('layouts.app')

@section('content')
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">{{ $shop->name }}</h4>
                    <span class="badge bg-info">Rating: {{ $shop->rating }}</span>
                </div>
                <div class="card-body">
                    <p><strong>Address:</strong> {{ $shop->address }}</p>
                    <p><strong>Phone:</strong> {{ $shop->phone }}</p>
                    <p><strong>Email:</strong> {{ $shop->email }}</p>
                    <p><strong>Description:</strong> {{ $shop->description }}</p>
                    <div class="mt-4">
                        <a href="{{ route('shops.edit', $shop) }}" class="btn btn-warning me-2">Edit</a>
                        <form action="{{ route('shops.destroy', $shop) }}" method="POST" style="display:inline-block">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                        <a href="{{ route('shops.index') }}" class="btn btn-secondary ms-2">Back</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection 
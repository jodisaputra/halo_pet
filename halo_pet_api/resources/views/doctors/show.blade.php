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

    <div class="card mx-auto mt-4" style="max-width: 500px;">
        <div class="card-body">
            <h5 class="card-title">Time Slots</h5>
            <form method="POST" action="{{ url('doctors/' . $doctor->id . '/time-slots') }}">
                @csrf
                <div class="row mb-2">
                    <div class="col">
                        <input type="time" name="start_time" class="form-control" required>
                    </div>
                    <div class="col">
                        <input type="time" name="end_time" class="form-control" required>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary">Add</button>
                    </div>
                </div>
            </form>
            <table class="table table-sm mt-3">
                <thead>
                    <tr>
                        <th>Start</th>
                        <th>End</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($doctor->timeSlots as $slot)
                        <tr>
                            <td>{{ $slot->start_time->format('H:i') }}</td>
                            <td>{{ $slot->end_time->format('H:i') }}</td>
                            <td>{{ $slot->is_available ? 'Available' : 'Unavailable' }}</td>
                            <td>
                                <form method="POST" action="{{ url('doctors/' . $doctor->id . '/time-slots/' . $slot->id) }}" style="display:inline;">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Delete this time slot?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection 
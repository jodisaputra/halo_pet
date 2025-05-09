class Doctor {
  final int id;
  final String name;
  final String specialty;
  final String? image;
  final String? location;
  final String? about;
  final String? workingTime;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    this.image,
    this.location,
    this.about,
    this.workingTime,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
      image: json['image'],
      location: json['location'],
      about: json['about'],
      workingTime: json['working_time'],
    );
  }
} 
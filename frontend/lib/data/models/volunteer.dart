// lib/data/models/volunteer.dart

class Volunteer {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String? location;
  final String? wilaya;
  final String? commune;
  final List<String>? skills;
  final bool availability;
  final String? imagePath;
  final DateTime? createdAt;

  Volunteer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.location,
    this.wilaya,
    this.commune,
    this.skills,
    required this.availability,
    this.imagePath,
    this.createdAt,
  });

  // Convert to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'location': location,
      'wilaya': wilaya,
      'commune': commune,
      'skills': skills?.join(','),
      'availability': availability ? 1 : 0,
      'image_path': imagePath,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  // Create from Map (from SQLite)
  factory Volunteer.fromMap(Map<String, dynamic> map) {
    return Volunteer(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      location: map['location'] as String?,
      wilaya: map['wilaya'] as String?,
      commune: map['commune'] as String?,
      skills: map['skills'] != null 
          ? (map['skills'] as String).split(',')
          : null,
      availability: map['availability'] == 1,
      imagePath: map['image_path'] as String? ?? 'assets/images/profile.png',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
    );
  }

  // Copy with method
  Volunteer copyWith({
    String? id,
    String? name,
    String? phone,
    String? location,
    String? wilaya,
    String? commune,
    List<String>? skills,
    bool? availability,
    String? imagePath,
    DateTime? createdAt,
  }) {
    return Volunteer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email,
      location: location ?? this.location,
      wilaya: wilaya ?? this.wilaya,
      commune: commune ?? this.commune,
      skills: skills ?? this.skills,
      availability: availability ?? this.availability,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  // Add this inside the Volunteer class
factory Volunteer.empty() {
  return Volunteer(
    id: '',
    name: '',
    phone: '',
    email: '',
    location: null,
    wilaya: null,
    commune: null,
    skills: [],
    availability: false,
    imagePath: 'assets/images/profile.png',
    createdAt: null,
  );
}

}
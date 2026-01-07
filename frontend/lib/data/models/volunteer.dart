import 'package:cloud_firestore/cloud_firestore.dart';

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

  // Certificate fields
  final String? certificateBase64;
  final String? certificateName; 
  final bool? certificateVerified;

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
    this.certificateBase64,
    this.certificateName,
    this.certificateVerified,
    this.createdAt,
  });

  // ================= SQLITE (LOCAL) =================
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

  factory Volunteer.fromMap(Map<String, dynamic> map) {
    return Volunteer(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      phone: map['phone']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      location: map['location']?.toString(),
      wilaya: map['wilaya']?.toString(),
      commune: map['commune']?.toString(),
      skills: map['skills'] != null && map['skills'].toString().isNotEmpty
          ? map['skills'].toString().split(',')
          : [],
      availability: map['availability'] == 1,
      imagePath: map['image_path']?.toString() ?? 'assets/images/profile.png',
      certificateBase64: null, // SQLite doesn't store this
      certificateName: null,
      certificateVerified: false,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }

  // ================= FIRESTORE (CLOUD) =================
  Map<String, dynamic> toFirestoreMap() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'location': location,
      'wilaya': wilaya,
      'commune': commune,
      'skills': skills ?? [], 
      'availability': availability,
      'imagePath': imagePath,
      'certificateVerified': certificateVerified ?? false,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };

    // ✅ SAFETY SHIELD: Only send if not null
    if (certificateBase64 != null) data['certificateBase64'] = certificateBase64;
    if (certificateName != null) data['certificateName'] = certificateName;

    return data;
  }

  factory Volunteer.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Volunteer(
      id: doc.id,
      name: data['name']?.toString() ?? '',
      phone: data['phone']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      location: data['location']?.toString(),
      wilaya: data['wilaya']?.toString(),
      commune: data['commune']?.toString(),
      skills: data['skills'] is List ? List<String>.from(data['skills']) : [],
      availability: data['availability'] == true,
      imagePath: data['imagePath']?.toString() ?? 'assets/images/profile.png',
      certificateBase64: data['certificateBase64']?.toString(),
      certificateName: data['certificateName']?.toString(),
      certificateVerified: data['certificateVerified'] == true,
      createdAt: data['createdAt'] is Timestamp ? (data['createdAt'] as Timestamp).toDate() : null,
    );
  }
}
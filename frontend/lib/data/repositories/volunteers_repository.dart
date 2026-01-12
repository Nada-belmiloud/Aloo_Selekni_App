import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'dart:io';

import '../models/volunteer.dart';
import '../services/database_helper.dart';

class VolunteersRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= 1. REGISTRATION & CLOUD STORAGE =================

  /// Registers a volunteer, converts image to Base64, and saves to both Cloud and Local
  Future<void> registerVolunteerWithCertificate({
    required Volunteer volunteer,
    required File certificateFile,
  }) async {
    try {
      // 1. Convert file to Base64
      final bytes = await certificateFile.readAsBytes();
      final base64String = base64Encode(bytes);

      // 2. Determine a valid ID (Ensures ID is never empty)
      String documentId = volunteer.id.isNotEmpty 
          ? volunteer.id 
          : volunteer.email.replaceAll(RegExp(r'[^\w\s]+'), '_'); 

      // 3. Prepare Cloud Data
      final cloudData = volunteer.toFirestoreMap();
      
      // 3.5 ✅ FIX: Clean the map before sending to Firestore
      // Firestore crashes if ANY value is null when it expects a String
      cloudData['certificateBase64'] = base64String;
      cloudData['status'] = 'pending';
      cloudData['id'] = documentId; // Ensure the ID in the data matches the doc ID

      // 4. ✅ UPLOAD TO FIRESTORE
      // .doc(documentId) must not be empty or null
      await _firestore.collection('volunteers').doc(documentId).set(
        cloudData, 
        SetOptions(merge: true)
      );

      // 5. SAVE TO SQLITE
      final db = await _dbHelper.database;
      // We use volunteer.toMap() for local storage
      await db.insert(
        'volunteers', 
        volunteer.toMap(), 
        conflictAlgorithm: ConflictAlgorithm.replace
      );
      
      print("✅ Registration Successful for: $documentId");
    } catch (e) {
      // This will print the EXACT reason for "Invalid Argument" in your console
      print("❌ Firestore Registration Error: $e");
      throw Exception("Registration failed: $e");
    }
  }

  // ================= 2. FETCHING (LOCAL vs CLOUD) =================

  /// ✅ FETCH FROM CLOUD: Use this for the Profile page to see the certificate
  Future<Volunteer?> getFullVolunteerFromCloud(String id) async {
    try {
      final doc = await _firestore.collection('volunteers').doc(id).get();
      if (doc.exists) return Volunteer.fromFirestore(doc);
    } catch (e) {
      print("Cloud Fetch Error: $e");
    }
    return null;
  }

  /// FETCH FROM LOCAL: Fast retrieval by ID
  Future<Volunteer?> getVolunteerById(String id) async {
    final db = await _dbHelper.database;
    final result = await db.query('volunteers', where: 'id = ?', whereArgs: [id], limit: 1);
    if (result.isEmpty) return null;
    return Volunteer.fromMap(result.first);
  }

  /// FETCH FROM LOCAL: Get all volunteers
  Future<List<Volunteer>> getAllVolunteers() async {
    final db = await _dbHelper.database;
    final result = await db.query('volunteers', orderBy: 'created_at DESC');
    return result.map((map) => Volunteer.fromMap(map)).toList();
  }

  // ================= 3. FILTERING & SEARCH (LOCAL) =================

  /// FETCH FROM LOCAL: Search by name
  Future<List<Volunteer>> searchVolunteersByName(String name) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'volunteers',
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
      orderBy: 'created_at DESC',
    );
    return result.map((map) => Volunteer.fromMap(map)).toList();
  }

  /// FETCH FROM LOCAL: Filter by Wilaya
  Future<List<Volunteer>> getVolunteersByWilaya(String wilaya) async {
    if (wilaya.isEmpty) return [];
    final db = await _dbHelper.database;
    final result = await db.query(
      'volunteers',
      where: 'wilaya = ?',
      whereArgs: [wilaya],
      orderBy: 'created_at DESC',
    );
    return result.map((map) => Volunteer.fromMap(map)).toList();
  }

  /// FETCH FROM LOCAL: Filter by Wilaya + Availability
  Future<List<Volunteer>> getAvailableVolunteersByWilaya(String wilaya) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'volunteers',
      where: 'wilaya = ? AND availability = ?',
      whereArgs: [wilaya, 1], // SQLite stores boolean as 1 (true)
      orderBy: 'created_at DESC',
    );
    return result.map((map) => Volunteer.fromMap(map)).toList();
  }

  // ================= 4. UPDATES & TOKEN SYNC =================

  Future<void> updateVolunteerStatus(String id, bool isAvailable) async {
    // Only update specific field in Firestore to protect certificate
    await _firestore.collection('volunteers').doc(id).update({
      'availability': isAvailable,
    });

    final db = await _dbHelper.database;
    await db.update(
      'volunteers', 
      {'availability': isAvailable ? 1 : 0}, 
      where: 'id = ?', 
      whereArgs: [id]
    );
  }

 
  Future<Volunteer?> getVolunteerByEmail(String email) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'volunteers',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return Volunteer.fromMap(result.first);
  }
}

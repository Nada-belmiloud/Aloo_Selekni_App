import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import '../services/database_helper.dart';
import '../models/volunteer.dart';

class FirebaseSyncService {
  static final FirebaseSyncService instance = FirebaseSyncService._init();
  FirebaseSyncService._init();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. PUSH local data to Cloud
  Future<void> syncOnStartup() async {
    try {
      final isAvailable = await _isCloudAvailable();
      if (!isAvailable) return;
      await _syncAllVolunteersMerged();
    } catch (e) {
      print('❌ Push sync failed: $e');
    }
  }

  // 2. PULL Cloud data to Local (Crucial for seeing other users)
  Future<void> pullVolunteersFromCloud() async {
    try {
      print('📥 Fetching all volunteers from Firestore...');
      final snapshot = await _firestore.collection('volunteers').get();
      final db = await DatabaseHelper.instance.database;
      final batch = db.batch();

      for (var doc in snapshot.docs) {
        final volunteer = Volunteer.fromFirestore(doc);
        batch.insert(
          'volunteers',
          volunteer.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
      print('✅ Successfully pulled ${snapshot.docs.length} volunteers from cloud');
    } catch (e) {
      print('❌ Pull sync failed: $e');
    }
  }

  Future<void> _syncAllVolunteersMerged() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('volunteers');
    for (final map in maps) {
      final volunteer = Volunteer.fromMap(map);
      final docRef = _firestore.collection('volunteers').doc(volunteer.id);
      await docRef.set(volunteer.toFirestoreMap(), SetOptions(merge: true));
    }
  }

  Future<bool> uploadCertificateBase64(File file, String volunteerId, String certificateName) async {
    try {
      final bytes = await file.readAsBytes();
      final base64String = base64Encode(bytes);
      await _firestore.collection('volunteers').doc(volunteerId).set({
        'certificateBase64': base64String,
        'certificateName': certificateName,
        'certificateVerified': false,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _isCloudAvailable() async {
    try {
      await _firestore.collection('_test').doc('test').get().timeout(const Duration(seconds: 3));
      return true;
    } catch (_) {
      return false;
    }
  }
}
// lib/data/repositories/volunteers_repository.dart
import 'package:sqflite/sqflite.dart';

import '../models/volunteer.dart';
import '../services/database_helper.dart';

class VolunteersRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Get all volunteers from database
  Future<List<Volunteer>> getAllVolunteers() async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'volunteers',
      orderBy: 'created_at DESC',
    );
    return result.map((map) => Volunteer.fromMap(map)).toList();
  }

  /// Get volunteers filtered by wilaya (Arabic name)
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

  /// Get volunteers filtered by availability
  Future<List<Volunteer>> getAvailableVolunteers() async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'volunteers',
      where: 'availability = ?',
      whereArgs: [1],
      orderBy: 'created_at DESC',
    );
    return result.map((map) => Volunteer.fromMap(map)).toList();
  }

  /// Get available volunteers by wilaya
  Future<List<Volunteer>> getAvailableVolunteersByWilaya(String wilaya) async {
    if (wilaya.isEmpty) return [];
    
    final db = await _dbHelper.database;
    final result = await db.query(
      'volunteers',
      where: 'wilaya = ? AND availability = ?',
      whereArgs: [wilaya, 1],
      orderBy: 'created_at DESC',
    );
    return result.map((map) => Volunteer.fromMap(map)).toList();
  }

  /// Insert a new volunteer
  Future<void> insertVolunteer(Volunteer volunteer) async {
    final db = await _dbHelper.database;
    await db.insert(
      'volunteers',
      volunteer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Update volunteer
  Future<void> updateVolunteer(Volunteer volunteer) async {
    final db = await _dbHelper.database;
    await db.update(
      'volunteers',
      volunteer.toMap(),
      where: 'id = ?',
      whereArgs: [volunteer.id],
    );
  }

  /// Delete volunteer
  Future<void> deleteVolunteer(String id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'volunteers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Get volunteer by ID
  Future<Volunteer?> getVolunteerById(String id) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'volunteers',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    if (result.isEmpty) return null;
    return Volunteer.fromMap(result.first);
  }

  /// Search volunteers by name
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
// lib/data/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();

  // Database instance
  static Database? _database;

  // Current DB version. Bump this when you add migrations.
  static const int _dbVersion = 2;
  static const String _dbName = 'allo_selekni.db';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  // Called only when DB is created for the first time.
  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const textTypeNullable = 'TEXT';
    const boolType = 'INTEGER NOT NULL';
    const realType = 'REAL';

    // 1. Volunteers Table (includes image_path and created_at)
    await db.execute('''
      CREATE TABLE volunteers (
        id $idType,
        name $textType,
        phone $textType,
        email $textTypeNullable, 
        location $textTypeNullable,
        wilaya $textTypeNullable,
        commune $textTypeNullable,
        skills $textTypeNullable,
        availability $boolType,
        image_path $textTypeNullable DEFAULT 'assets/images/profile.png',
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // 2. Users Table
    await db.execute('''
      CREATE TABLE users (
        id $idType,
        name $textType,
        phone $textType,
        email $textTypeNullable,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // 3. Emergency Contacts Table
    await db.execute('''
      CREATE TABLE emergency_contacts (
        id $idType,
        user_id $textType,
        full_name $textType,
        phone $textType,
        relation $textTypeNullable,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // 4. Ambulances Table
    await db.execute('''
      CREATE TABLE ambulances (
        id $idType,
        company_name $textType,
        phone $textType,
        price $realType,
        region $textTypeNullable,
        wilaya $textTypeNullable,
        is_available $boolType,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Indexes
    await db.execute('CREATE INDEX idx_volunteers_wilaya ON volunteers(wilaya)');
  }

  // Migrations: handle upgrades from older versions to newer versions
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Migration from version 1 -> 2: add image_path to volunteers table
    if (oldVersion < 2) {
      // Add the column with a default value so existing rows are safe.
      await db.execute(
        "ALTER TABLE volunteers ADD COLUMN image_path TEXT DEFAULT 'assets/images/profile.png';"
      );

      // Defensive update: ensure no NULL values remain (just in case).
      await db.execute(
        "UPDATE volunteers SET image_path = 'assets/images/profile.png' WHERE image_path IS NULL;"
      );
    }

    // Future migrations can be chained like:
    // if (oldVersion < 3) { ... }
  }

  // Close the database
  Future close() async {
    final db = await instance.database;
    await db.close();
    _database = null;
  }

}

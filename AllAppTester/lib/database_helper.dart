import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'image_data.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'allapptester_database.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        imagePath TEXT
      )
    ''');
  }

  Future<int> insertImageData(ImageData imageData) async {
    Database db = await instance.database;
    return await db.insert('images', imageData.toMap());
  }

  Future<List<ImageData>> getImageDataList() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('images');
    return List.generate(maps.length, (i) {
      return ImageData(
        id: maps[i]['id'],
        description: maps[i]['description'],
        imagePath: maps[i]['imagePath'],
      );
    });
  }
}

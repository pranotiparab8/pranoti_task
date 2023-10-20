import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If the database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final pathToDatabase = path.join(databasePath, 'remainder_database.db');

    return await openDatabase(pathToDatabase, version: 1,
        onCreate: (db, version) async {
      // Create your tables here
      await db.execute('''
        CREATE TABLE tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          taskName TEXT,
          date TEXT,
          frequency TEXT
        )
      ''');
    });
  }

  Future<int> insertTask(Map<String, dynamic> taskData) async {
    final database = await this.database;
    return await database.insert('tasks', taskData);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final database = await this.database;
    return await database.query('tasks');
  }

  Future<int> updateTask(int id, Map<String, dynamic> taskData) async {
    final database = await this.database;
    return await database
        .update('tasks', taskData, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTask(int id) async {
    final database = await this.database;
    return await database.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}

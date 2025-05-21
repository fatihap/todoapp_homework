import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    return _db ??= await _initDb();
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'todos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE toDos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');
      },
    );
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query('toDos');
    return maps.map((map) => Todo.fromMap(map)).toList();
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return await db.insert('toDos', todo.toMap());
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    return await db.update('toDos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete('toDos', where: 'id = ?', whereArgs: [id]);
  }
}

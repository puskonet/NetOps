import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getLastTasks();
  Future<void> cacheTasks(List<TaskModel> tasks);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'netops.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE tasks(id TEXT PRIMARY KEY, title TEXT, address TEXT, status TEXT, isSynced INTEGER)',
        );
      },
    );
  }

  @override
  Future<List<TaskModel>> getLastTasks() async {
    final db = await database;
    final maps = await db.query('tasks');

    return maps.map((row) => TaskModel.fromTable(row)).toList();
  }

  @override
  Future<void> cacheTasks(List<TaskModel> tasks) async {
    final db = await database;

    // ❗ Fastest way untuk replace data agar tidak freeze
    await db.transaction((txn) async {
      await txn.delete('tasks');

      final batch = txn.batch();
      for (var task in tasks) {
        batch.insert(
          'tasks',
          task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }
}

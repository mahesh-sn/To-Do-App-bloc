import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app_bloc/Model/task_model.dart';

class DatabaseService {
  static Database? _db;
  DatabaseService._instance();

  static final DatabaseService databaseService = DatabaseService._instance();

  Future<Database?> get database async {
    if (_db != null) return _db;
    _db = await getDatabase();
    return _db;
  }

  static final _tasksTable = "tasks";
  static final String _taskContent = "taskContent";
  static final String _taskId = "taskId";
  static final String _taskStatus = "taskStatus";
  static final String SQL_CREATE_TASK_TABLE = '''
  CREATE TABLE  $_tasksTable (
    $_taskId INTEGER PRIMARY KEY,
    $_taskContent TEXT NOT NULL,
    $_taskStatus INTEGER NOT NULL
  )
  ''';

  Future<Database> getDatabase() async {
    try {
      Database database;
      String databasesDirPath = await getDatabasesPath();
      String databasePath = await join(databasesDirPath, "master_db.db");
      database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(SQL_CREATE_TASK_TABLE);
        },
      );
      print("Database is Open");
      return database;
    } catch (e) {
      print("Exception Occured While getting the database- $e");
      rethrow;
    }
  }

  Future<int?> addNewTask(String taskCon) async {
    try {
      Database? db = await database;
      return await db
          ?.insert(_tasksTable, {_taskContent: taskCon, _taskStatus: 0});
    } catch (e) {
      print("Exception Occured while inserting the Task $taskCon");
    }
  }

  Future<List<Task>> getAllTasks() async {
    try {
      Database? db = await database;
      var data = await db?.query(_tasksTable);
      List<Task> tasks = data
              ?.map(
                (e) => Task(
                    taskContent: e[_taskContent] as String,
                    taskId: e[_taskId] as int,
                    taskStatus: e[_taskStatus] as int),
              )
              .toList() ??
          [];
      print("Got Data from DB as List<Task>");
      return tasks;
    } catch (e) {
      print("Exception occured while getting the task from db- $e");
      rethrow;
    }
  }

  Future<void> updateTaskStatus(int taskId, int taskStatus) async {
    try {
      Database? db = await database;
      await db?.update(_tasksTable, {_taskStatus: taskStatus},
          where: "$_taskId= ? ", whereArgs: [taskId]);
      print("Updated Status of the task with ID- $taskId");
    } catch (e) {
      print("Error while Getting the Task With Id-$taskId Error-$e");
    }
  }

  Future<void> deleteAllTaskById(List<int> taskIds) async {
    for (int i = 0; i < taskIds.length; i++) {
      try {
        int currentTaskId = taskIds[i];
        Database? db = await database;
        db?.delete(_tasksTable,
            where: "$_taskId = ? ", whereArgs: [currentTaskId]);
        print("Deleted task with Id- ${currentTaskId}");
      } catch (e) {
        print("Exception occured while deleting task with ID- ${taskIds[i]}");
        print("Exception is- $e");
      }
    }
  }
}

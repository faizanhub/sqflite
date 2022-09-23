import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practise/core/models/student.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/students.db';

    // open/ create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE tbl_student (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  name TEXT,
                  course TEXT,
                  mobile TEXT, 
                  totalFee INTEGER, 
                  feePaid INTEGER )
    
    ''');
  }

  ///functions of database
  Future<int> insertStudent(Student student) async {
    Database db = await instance.database;
    int result = await db.insert('tbl_student', student.toJson());

    return result;

    // db.rawInsert('INSERT INTO tbl_student(name, course, mobile, totalFee, feePaid) VALUES("some name", 1234, 456.789)');
  }

  Future<List<Student>> getAllStudent() async {
    Database db = await instance.database;

    List<Map<String, Object?>> listOfMaps = await db.query('tbl_student');

    return listOfMaps.map((student) => Student.fromJson(student)).toList();
  }

  Future<int> deleteStudentById(int id) async {
    Database db = await instance.database;

    int result =
        await db.delete('tbl_student', where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<int> updateStudentById(Student student) async {
    Database db = await instance.database;

    int result = await db.update('tbl_student', student.toJson(),
        where: 'id = ?', whereArgs: [student.id]);

    return result;
  }
}

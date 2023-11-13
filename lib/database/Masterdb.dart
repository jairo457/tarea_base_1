import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:tarea_base_1/models/CareerModel.dart';
import 'package:tarea_base_1/models/ProfesorModel.dart';
import 'package:tarea_base_1/models/TaskModel.dart';

class MasterDB {
  static final nameDB = 'MASTERDB';
  static final versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String query1 = '''CREATE TABLE tblCarrera(
        IdCareer INTEGER PRIMARY KEY,
        NameCareer VARCHAR(100)
    );''';
    String query2 = '''CREATE TABLE tblProfesor(
        IdProfesor INTEGER PRIMARY KEY,
        NameProfesor VARCHAR(100),
        NameSubject VARCHAR(100),
        IdCareer INTEGER,
        FOREIGN KEY (IdCareer) REFERENCES tblCarrera (IdCareer) 
    );''';
    String query3 = '''CREATE TABLE tblTareas (
        IdTask INTEGER PRIMARY KEY,
        NameTask VARCHAR(50),
        DscTask VARCHAR(50),
        SttTask BYTE,
        FECRECORDATORIO VARCHAR(11),
        IdProfesor INTEGER,
        FOREIGN KEY (IdProfesor) REFERENCES tblProfesor (IdProfesor)
    );''';
    db.execute(query1);
    db.execute(query2);
    db.execute(query3);
  }

//Career---------------------------------------
  Future<int> INSERT_Career(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE_Career(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'IdCareer = ?', whereArgs: [data['IdCareer']]);
  }

  Future<int> DELETE_Career(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'IdCareer = ?', whereArgs: [idTask]);
  }

  Future<List<CareerModel>> GETALL_Career() async {
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    return result
        .map((task) => CareerModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
  }

  Future<int> GETALL_Career_can() async {
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    result
        .map((task) => CareerModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
    return result.length;
  }

  Future<List<dynamic>> GETALL_Career_list() async {
    var conexion = await database;
    var list = [];
    list = await conexion!.query('tblCarrera', columns: ['NameCareer']);
    return list;
  }

//Profesor--------------------------------------
  Future<int> INSERT_Profesor(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE_Profesor(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'IdProfesor = ?', whereArgs: [data['IdProfesor']]);
  }

  Future<int> DELETE_Profesor(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'IdProfesor = ?', whereArgs: [idTask]);
  }

  Future<List<ProfesorModel>> GETALL_Profesor() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfesor');
    return result
        .map((task) => ProfesorModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
  }

  Future<int> GETALL_Profesor_can() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfesor');
    result
        .map((task) => ProfesorModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
    return result.length;
  }

  Future<int> GETCAREER_PROFESOR(int Carer) async {
    var conexion = await database;
    var result = await conexion!
        .rawQuery('SELECT * FROM tblProfesor WHERE IdCareer = ?', [Carer]);
    result
        .map((task) => ProfesorModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
    return result.length;
  }

  Future<List<ProfesorModel>> GET_Profesor(int id) async {
    var conexion = await database;
    var result = await conexion!
        .rawQuery('SELECT * FROM tblProfesor WHERE IdProfesor = ?', [id]);
    return result
        .map((task) => ProfesorModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
  }

//Task------------------------------------------
  Future<int> INSERT_Task(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE_Task(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'IdTask = ?', whereArgs: [data['IdTask']]);
  }

  Future<int> DELETE_Task(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }

  Future<List<TaskModel>> GETALL_Task() async {
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result
        .map((task) => TaskModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
  }

  Future<int> GETTASK_PROFESOR(int profe) async {
    var conexion = await database;
    var result = await conexion!
        .rawQuery('SELECT * FROM tblTareas WHERE IdProfesor = ?', [profe]);
    result
        .map((task) => TaskModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
    return result.length;
  }
}

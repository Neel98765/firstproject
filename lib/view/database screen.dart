import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbname = 'loginpage.db';
  static final _dbVersion = 1;

  DatabaseHelper.privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _checkPermission();
    return _database!;
  }

  var status;

  _checkPermission() async {
    // this.status = await Permission.storage.status;
    // if (await Permission.storage.request().isGranted) {
    return await _initiateDatabase();
    //  } else if (await Permission.storage.request().isDenied) {
    //   exit(0);
    // } else if (await Permission.storage.request().isPermanentlyDenied) {
    //    exit(0);
    //  }
  }

  Future _initiateDatabase() async {
    Directory? directory = await getExternalStorageDirectory();

    String path = join(directory!.path, _dbname);
    print(path);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("DROP TABLE IF EXISTS user");
    await db.execute('''CREATE TABLE user(Employee_No INTEGER NOT NULL, 
        Employee_NAME TEXT NOT NULL,
        Company_Name TEXT NOT NULL, 
        Branch_Name TEXT NOT NULL, 
        Main_Dept_NAME TEXT NOT NULL, 
        Sub_Dept_NAME TEXT NOT NULL, 
        Position_NAME TEXT NOT NULL, 
        JOBTitle_Name TEXT NOT NULL, 
        DOJ TEXT NOT NULL, 
        DOR TEXT NOT NULL, 
        EMP_GROUP TEXT NOT NULL, 
        EMP_LEVEL TEXT NOT NULL, 
        HOD TEXT NOT NULL, 
        EMAILID TEXT NOT NULL, 
        MANDT TEXT NOT NULL, 
        Latitude TEXT NOT NULL, 
        Longitude TEXT NOT NULL, 
        HOD_EMP_CODE TEXT NOT NULL, 
        isHOD TEXT NOT NULL, 
        isManual TEXT NOT NULL, 
        Attatchment TEXT NOT NULL, 
        Contact1 TEXT NOT NULL, 
        status TEXT NOT NULL)''');
  }

  Future<int> insertuser(Map<String, dynamic> data) async {
    Database db = await instance.database;
    return await db.insert("user", data);
  }

  Future<int> deleteuser() async {
    Database db = await instance.database;
    return await db.delete("user");
  }

  getuserdata() async {
    Database db = await instance.database;
    return await db.query("user");
  }
}

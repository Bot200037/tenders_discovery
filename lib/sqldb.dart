// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb extends ChangeNotifier{

  static Database? _db;
  Future<Database?> get db async{
    if(_db == null){
      _db = await intialDb();
      return _db;
    }
    else{
      return _db;
    }
  }

  intialDb() async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,'database.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate ,version: 1 ,onUpgrade: _onUpgrade);
    return mydb;
  }
  _onCreate(Database db, int version)async{
    Batch batch = db.batch();
    batch.execute('''
      CREATE TABLE "users" (
        "user_id" INTEGER PRIMARY KEY AUTOINCREMENT, 
        "user_name" TEXT, 
        "user_email" TEXT,
        "user_mobile" TEXT,
        "user_password" TEXT,
        "user_type" TEXT)
''');
/*
    batch.execute('''
      CREATE TABLE "products" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT, 
        "name" TEXT NOT NULL, 
        "price" TEXT NOT NULL,
        "description" TEXT NOT NULL,
        "image" TEXT NOT NULL,
        "user" TEXT NOT NULL)
''');
*/
    await batch.commit();
    print('Create Database and Table ===============================================');
  }

  _onUpgrade(Database db, int oldversion, int newversion)async{

  }

  mydeleteDatabase()async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,'database.db');
    await deleteDatabase(path);
  }

  login(String sql) async{
    //var response = await mydb.rawQuery("SELECT * FROM users WHERE usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  singup(String table , Map<String, Object?> values) async{
    Database? mydb = await db;
    int response = await mydb!.insert(table , values);
    return response;
  }

  readData(String sql) async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    notifyListeners();
    return response;
  }
  insertData(String sql) async{
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  updateData(String sql) async{
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
  deleteData(String sql) async{
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
  searchData(String sql) async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    notifyListeners();
    return response;
  }


}
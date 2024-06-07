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
    batch.execute('''
      CREATE TABLE "tenders" (
        "tenderId" INTEGER PRIMARY KEY AUTOINCREMENT, 
        "tenderTitle" TEXT, 
        "tenderLocation" TEXT,
        "startedDate" TEXT,
        "finishedDate" TEXT,
        "tenderCategory" TEXT,
        "tenderDescription" TEXT,
        "user_id" INTEGER,
        FOREIGN KEY ("user_id") REFERENCES "users"("user_id")
        )
''');
    batch.execute('''
      CREATE TABLE "contracts" (
        "contractId" INTEGER PRIMARY KEY AUTOINCREMENT, 
        "contractDescription" TEXT,
        "user_id" INTEGER,
        FOREIGN KEY ("user_id") REFERENCES "users"("user_id"),
        "tenderId" INTEGER,
        FOREIGN KEY ("tenderId") REFERENCES "tenders"("tenderId")
        )
''');
    batch.execute('''
      CREATE TABLE "contract_status" (
        "con_statusId" INTEGER PRIMARY KEY AUTOINCREMENT, 
        "contractStatus" TEXT,
        "contractId" INTEGER,
        FOREIGN KEY ("contractId") REFERENCES "contracts"("contractId")
        )
''');
    batch.execute('''
      CREATE TABLE "tender_request" (
        "tend_requestId" INTEGER PRIMARY KEY AUTOINCREMENT, 
        "requestStatus" TEXT,
        "user_id" INTEGER,
        FOREIGN KEY ("user_id") REFERENCES "users"("user_id")
        )
''');



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
  Future<bool> login(String sql) async{
    final Database mydb = await intialDb();
    var response = await mydb.rawQuery(sql);
    if(response.isNotEmpty){
      return true;
    } else {
      return false;
    }
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
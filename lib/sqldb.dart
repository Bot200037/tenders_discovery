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
        "user_name" TEXT, 
        "user_id" INTEGER,
        FOREIGN KEY ("user_id") REFERENCES "users"("user_id")
        )
''');
    batch.execute('''
      CREATE TABLE "contracts" (
        "contractId" INTEGER PRIMARY KEY AUTOINCREMENT, 
        "user_name" TEXT, 
        "user_mobile" TEXT,
        "user_id" INTEGER,
        "tenderId" INTEGER,
        "contractDescription" TEXT,
        FOREIGN KEY ("user_id") REFERENCES "users"("user_id"),
        FOREIGN KEY ("tenderId") REFERENCES "tenders"("tenderId")
        )
''');
    batch.execute('''
      CREATE TABLE "contract_status" (
        "con_statusId" INTEGER PRIMARY KEY AUTOINCREMENT, 
        "contractId" INTEGER,
        "contractStatus" TEXT,
        FOREIGN KEY ("contractId") REFERENCES "contracts"("contractId")
        )
''');
    batch.execute('''
      CREATE TABLE "tender_request" (
        "tend_requestId" INTEGER PRIMARY KEY AUTOINCREMENT, 
        "user_id" INTEGER,
        "user_name" TEXT,
        "tenderTitle" TEXT,
        "requestStatus" TEXT,
        FOREIGN KEY ("user_id") REFERENCES "users"("user_id")

        )
''');
    batch.execute('''
      CREATE TABLE "current_user" (
        "user_id" INTEGER, 
        "user_name" TEXT, 
        "user_email" TEXT,
        "user_mobile" TEXT,
        "user_password" TEXT,
        "user_type" TEXT
        )
''');
    batch.execute('''
      CREATE TABLE "current_request" (
        "tend_requestId" INTEGER, 
        "user_id" INTEGER,
        "user_name" TEXT,
        "tenderTitle" TEXT,
        "requestStatus" TEXT
        )
''');
    batch.execute('''
      CREATE TABLE "current_tender" (
        "tenderId" INTEGER, 
        "tenderTitle" TEXT, 
        "tenderLocation" TEXT,
        "startedDate" TEXT,
        "finishedDate" TEXT,
        "tenderCategory" TEXT,
        "tenderDescription" TEXT,
        "user_name" TEXT,
        "user_id" INTEGER
        )
''');

/*     await db.insert('users', {'user_id': 1, 'user_name': 'Ali', 'user_email': 'ali@example.com', 'user_mobile': '770211093', 'user_password': '770', 'user_type': 'Contractor'});
    await db.insert('users', {'user_id': 2, 'user_name': 'Jane Smith', 'user_email': 'jane@example.com', 'user_mobile': '0987654321', 'user_password': 'password456', 'user_type': 'Contractor'});
    await db.insert('users', {'user_id': 3, 'user_name': 'Alice Johnson', 'user_email': 'alice@example.com', 'user_mobile': '1122334455', 'user_password': 'password789', 'user_type': 'Contractor'});
    await db.insert('users', {'user_id': 4, 'user_name': 'Bob Brown', 'user_email': 'bob@example.com', 'user_mobile': '2233445566', 'user_password': 'password101', 'user_type': 'Tender'});

    await db.insert('tenders', {'tenderId': 1, 'tenderTitle': 'Road Construction', 'tenderLocation': 'City A', 'startedDate': '2024-01-01', 'finishedDate': '2024-12-31', 'tenderCategory': 'Infrastructure', 'tenderDescription': 'Construction of a new road', 'user_name': 'John Doe'});
    await db.insert('tenders', {'tenderId': 2, 'tenderTitle': 'School Building', 'tenderLocation': 'City B', 'startedDate': '2024-02-01', 'finishedDate': '2024-11-30', 'tenderCategory': 'Education', 'tenderDescription': 'Construction of a new school', 'user_name': 'Jane Smith'});
    await db.insert('tenders', {'tenderId': 3, 'tenderTitle': 'Hospital Renovation', 'tenderLocation': 'City C', 'startedDate': '2024-03-01', 'finishedDate': '2024-10-31', 'tenderCategory': 'Healthcare', 'tenderDescription': 'Renovation of an old hospital', 'user_name': 'Alice Johnson'});
    await db.insert('tenders', {'tenderId': 4, 'tenderTitle': 'Park Development', 'tenderLocation': 'City D', 'startedDate': '2024-04-01', 'finishedDate': '2024-09-30', 'tenderCategory': 'Recreation', 'tenderDescription': 'Development of a new park', 'user_name': 'Bob Brown'});

    await db.insert('contracts', {'contractId': 1, 'user_id': 1, 'user_name': 'John Doe', 'user_mobile': '1234567890', 'tenderId': 1, 'tenderTitle': 'Road Construction', 'contractDescription': 'Contract for the construction of a new road'});
    await db.insert('contracts', {'contractId': 2, 'user_id': 2, 'user_name': 'Jane Smith', 'user_mobile': '0987654321', 'tenderId': 2, 'tenderTitle': 'School Building', 'contractDescription': 'Contract for the construction of a new school'});
    await db.insert('contracts', {'contractId': 3, 'user_id': 3, 'user_name': 'Alice Johnson', 'user_mobile': '1122334455', 'tenderId': 3, 'tenderTitle': 'Hospital Renovation', 'contractDescription': 'Contract for the renovation of an old hospital'});
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
    Future<Map<String,dynamic>?> getOneRow(String table) async{
    final Database mydb = await intialDb();
    List<Map<String,dynamic>> response = await mydb.query(table ,limit: 1);
    if(response.isNotEmpty){
      return response.first;
    } else {
      return null;
    }
  }
  Future<bool> check(String sql) async{
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
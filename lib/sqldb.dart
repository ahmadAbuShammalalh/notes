

import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class SqlDb {

  static Database? _db;
  Future<Database?> get db async {
    if(_db ==null){
      _db = await intialDb();
      return _db;
    }else{
      return _db;
    }


  }

  intialDb()async{
    String dataBaseBath = await getDatabasesPath();
    String path = join(dataBaseBath,'ahmad.db');
    Database mydb = await openDatabase(path , onCreate: _onCreate ,version: 4,onUpgrade: _onUpgrade);
    return mydb;
  }
  _onUpgrade(Database db ,int oldVersion ,int newVersion )async{
     print("_onUpgrade=========================");
  }

  _onCreate(Database db , int version)async{
    await db.execute(
      '''
      CREATE TABLE "notes"(
      "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT ,
      "note" TEXT NOT NULL
      )
      '''
    );
    print('_onCreate===================');

  }

  readData(String sql)async{
    Database? mydb = await db ;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }
  insertData(String sql)async{
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  updateData(String sql)async{
    Database? mydb = await db ;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
  deleteData(String sql)async{
    Database? mydb = await db ;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
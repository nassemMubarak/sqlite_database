import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DBProvider{
  late final Database _database;
  static final DBProvider _instance = DBProvider._internal();
  DBProvider._internal();
  factory DBProvider(){
    return _instance;
  }
  Database get database=>_database;
  Future<void> initDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'app_database.sql');
   _database =  await openDatabase(
      path,
      version: 1,
      onOpen: (Database db){},
      onCreate: (Database db, int version) async{
        await db.execute('CREATE TABLE contacts ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT,'
            'mobile TEXT,'
            'blocked BIT'
            ')');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion){},
      onDowngrade: (Database db, int oldVersion, int newVersion){},

    );
  }
}
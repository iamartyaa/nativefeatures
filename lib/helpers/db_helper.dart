import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';

class DBHelper {
  static Future<sql.Database> database() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath,'places.db'), version: 1,onCreate: (db, version) {
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT, image TEXT)',);
    },);
  }

  static Future<void> insert(String table,Map<String,Object> data) async {
    
   final db= await DBHelper.database();
   db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace,);
  } 

  static Future<List<Map<String,dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    print(db.query(table));
    return db.query(table);
  } 
}
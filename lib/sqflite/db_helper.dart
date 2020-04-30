import 'dart:async';

import 'package:contact_manager/sqflite/favourites_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'user_db.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'test.db');
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a tables on onCreate
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(UserDb.createTableQuery);
    await db.execute(FavouritesDb.createTableQuery);
    print("Created tables");
  }
}

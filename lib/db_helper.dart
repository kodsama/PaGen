import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'models/quote.dart';

class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'quotes_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static final table = 'quotes';
  static final version = 1;
  var dbPath;

  Future<Database> get database async {
    // Construct the path to the app's writable database file:
    var dbDir = await getDatabasesPath();
    dbPath = join(dbDir, databaseName);

    return await openDatabase(dbPath, version: version,
      onOpen: _onOpen, onCreate: _onCreate);
  }

  Future<bool> _isDbValid(Database db) async {
    List tablesList = await db.rawQuery(
      "SELECT * FROM sqlite_master WHERE name ='$table' and type='table'"
      );
    if (tablesList.length != 1) {
      print('Available tables in db: $tablesList');
      return false;
    }
    return true;
  }

  _onOpen(Database db) async {
    // Database is open, print its version
    print('db version ${await db.getVersion()}');
    if (! await _isDbValid(db)) {
      print('Invalid db, create a new one.');
      db.close();
      _onCreate(db, version);
    }
    // print('db validity = ${await _isDbValid(db)}');
  }

  _onCreate(Database db, int version) async {
    // await deleteDatabase(dbPath); // Delete any existing database
    // await db.execute(orderModelCreateString);
    var data = await rootBundle.load('assets/init_quotes.db');
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes
    );
    await File(dbPath).writeAsBytes(bytes);
    
  }

  insertQuote(QuoteModel quote) async {
    final Database db = await database;
    quote.id = await db.insert(
      DatabaseHelper.table,
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // print('Inserted ${quote.id}');
  }

  Future<List<Map<String, dynamic>>> retrieveAllQuotes() async {
    final Database db = await database;

    var results = await db.query(DatabaseHelper.table);
    return results;
  }

  updateQuote(QuoteModel quote) async {
    final db = await database;

    // Update the given Quote.
    await db.update(
      DatabaseHelper.table,
      quote.toMap(),
      // Ensure that the Quote has a matching id.
      where: "id = ?",
      // Pass the Quote's id as a whereArg to prevent SQL injection.
      whereArgs: [quote.id],
    );
  }

  deleteQuote(int id) async {
    final db = await database;

    await db.delete(
      DatabaseHelper.table,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

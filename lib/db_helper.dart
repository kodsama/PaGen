import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'models/quote.dart';
import 'utils/app_logger.dart';

class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'quotes_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static const table = 'quotes';
  static const version = 1;
  late String dbPath;

  Future<Database> get database async {
    // Construct the path to the app's writable database file:
    final dbDir = await getDatabasesPath();
    dbPath = join(dbDir, databaseName);

    return await openDatabase(dbPath,
        version: version, onOpen: _onOpen, onCreate: _onCreate);
  }

  Future<bool> _isDbValid(Database db) async {
    final tablesList = await db.rawQuery(
        "SELECT * FROM sqlite_master WHERE name ='$table' and type='table'");
    if (tablesList.length != 1) {
      AppLogger.warning('Available tables in db: $tablesList');
      return false;
    }
    return true;
  }

  Future<void> _onOpen(Database db) async {
    AppLogger.debug('Opened database, version ${await db.getVersion()}');
    if (!await _isDbValid(db)) {
      AppLogger.warning('Invalid db, creating a new one.');
      await db.close();
      await _onCreate(db, version);
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    final data = await rootBundle.load('assets/init_quotes.db');
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(dbPath).writeAsBytes(bytes);
    AppLogger.info('Initialized quotes database from bundled asset.');
  }

  Future<void> insertQuote(QuoteModel quote) async {
    final Database db = await database;
    quote.id = await db.insert(
      DatabaseHelper.table,
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    AppLogger.debug('Inserted quote ${quote.id}');
  }

  Future<void> gradeQuote(QuoteModel quote, int increment) async {
    quote.grade = (quote.grade ?? 0) + increment;
    final Database db = await database;
    await db.update(
      DatabaseHelper.table,
      quote.toMap(),
      where: 'id = ?',
      whereArgs: [quote.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    AppLogger.debug('Updated grade of quote ${quote.id} by $increment');
  }

  Future<List<Map<String, dynamic>>> retrieveAllQuotes() async {
    final Database db = await database;

    final results = await db.query(DatabaseHelper.table);
    return results;
  }

  Future<void> updateQuote(QuoteModel quote) async {
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

  Future<void> deleteQuote(int id) async {
    final db = await database;

    await db.delete(
      DatabaseHelper.table,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:typed_data';

class DatabaseHandler {
  //Create a private constructor
  DatabaseHandler._();

  static const databaseName = 'quotes_database.db';
  static final DatabaseHandler instance = DatabaseHandler._();
  static Database _database;

  Future<Database> get database async {
    // Construct the path to the app's writable database file:
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, databaseName);

    // Delete any existing database:
    await deleteDatabase(dbPath);

    // Create the writable database file from the bundled demo database file:
    // final AssetBundle rootBundle = _initRootBundle()
    var data = await rootBundle.load('assets/init_quotes.db');
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes
    );
    await File(dbPath).writeAsBytes(bytes);
    return await openDatabase(dbPath);
  }

  // initializeDatabase() async {
  //   return await openDatabase(join(await getDatabasesPath(), databaseName),
  //     version: 1, onCreate: (Database db, int version) async {
  //     await db.execute(
  //         "CREATE TABLE quotes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, level INTEGER, theme TEXT, text TEXT, source TEXT)");
  //   });
  // }

  insertQuote(QuoteModel quote) async {
    final Database db = await database;

    await db.insert(
      'quotes',
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> retrieveAllQuotes() async {
    final Database db = await database;

    var results = await db.query('quotes');
    return results;
  }

  updateQuote(QuoteModel quote) async {
    final db = await database;

    // Update the given Quote.
    await db.update(
      'quotes',
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
      'quotes',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

class QuoteModel {
  int id;
  int level;
  String theme;
  String text;
  String source;

  QuoteModel({
    this.id,
    this.level,
    this.theme,
    this.text,
    this.source
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level': level,
      'theme': theme,
      'text': text,
      'source': source,
    };
  }

  QuoteModel.fromMap(Map<String, dynamic> result) {
    this.id = result['id'];
    this.theme = result['theme'];
    this.level = result['level'];
    this.text = result['text'];
    this.source = result['source'];
  }

  @override
  String toString() {
    return 'QuoteModel{id: $id, lvl: $level, theme: $theme, text: $text, src: $source}';
  }
}

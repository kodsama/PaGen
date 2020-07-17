import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  //Create a private constructor
  DatabaseHandler._();

  static const databaseName = 'quotes_database.db';
  static final DatabaseHandler instance = DatabaseHandler._();
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  removeDatabase() async {
    await deleteDatabase(join(await getDatabasesPath(), databaseName));
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
      version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE quotes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, level INTEGER, theme TEXT, text TEXT, source TEXT)");
    });
  }

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
    // Convert the List<Map<String, dynamic> into a List<QuoteModel>.
    // return List.generate(results.length, (i) {
    //   return QuoteModel(
    //     id: results[i]['id'],
    //     theme: results[i]['theme'],
    //     level: results[i]['level'],
    //     text: results[i]['text'],
    //     source: results[i]['source'],
    //   );
    // });
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

// void test() async {
//   var q1 = QuoteModel(
//     id: 0,
//     level: 1,
//     theme: 'Public',
//     text: 'Public quote of level 1',
//     source: 'None',
//   );

//   // Insert a quote into the database.
//   await insertQuote(q1);

//   // Print the list of quotes (only Fido for now).
//   print(await quotes());

//   // Update Fido's age and save it to the database.
//   q1 = QuoteModel(
//     id: q1.id,
//     theme: q1.theme,
//     level: 2,
//     text: q1.text,
//     source: q1.source,
//   );
//   await updateQuote(q1);

//   // Print Fido's updated information.
//   print(await quotes());

//   // Delete Fido from the database.
//   await deleteQuoteModel(q1.id);

//   // Print the list of quotes (empty).
//   print(await quotes());
// }

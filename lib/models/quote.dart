
class QuoteModel {
  int id;
  String origin;
  int level;
  String theme;
  String text;
  String source;
  int grade;

  QuoteModel({
    this.id,
    this.origin,
    this.level,
    this.theme,
    this.text,
    this.source,
    this.grade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'origin': origin,
      'level': level,
      'theme': theme,
      'text': text,
      'source': source,
      'grade': grade,
    };
  }

  QuoteModel.fromMap(Map<String, dynamic> result) {
    this.id = result['id'];
    this.origin = result['origin'];
    this.theme = result['theme'];
    this.level = result['level'];
    this.text = result['text'];
    this.source = result['source'];
    this.grade = result['grade'];
  }

  @override
  String toString() {
    return 'QuoteModel{id: $id, orig:$origin, lvl: $level, theme: $theme, text: $text, src: $source, grade: $grade}';
  }
}

String orderModelCreateString = '''
  CREATE TABLE "quotes" (
    "id" INTEGER NOT NULL,
    "origin" TEXT DEFAULT "Custom",
    "level" INTEGER NOT NULL DEFAULT 1,
    "theme" TEXT NOT NULL DEFAULT "Random",
    "text" TEXT NOT NULL,
    "source" TEXT DEFAULT "",
    "grade" INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY("id" AUTOINCREMENT));
  ''';

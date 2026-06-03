
class QuoteModel {
  int? id;
  String? locale;
  String? origin;
  int? level;
  String? theme;
  String? text;
  String? source;
  int? grade;

  QuoteModel({
    this.id,
    this.locale,
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
      'locale': locale,
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
    this.locale = result['locale'];
    this.origin = result['origin'];
    this.theme = result['theme'];
    this.level = result['level'];
    this.text = result['text'];
    this.source = result['source'];
    this.grade = result['grade'];
  }

  @override
  String toString() {
    return 'QuoteModel{id: $id, lang: $locale, orig:$origin, lvl: $level, theme: $theme, text: $text, src: $source, grade: $grade}';
  }
}

String orderModelCreateString = '''
  CREATE TABLE "quotes" (
    "id" INTEGER NOT NULL,
    "locale" TEXT DEFAULT "en",
    "origin" TEXT DEFAULT "Custom",
    "level" INTEGER NOT NULL DEFAULT 1,
    "theme" TEXT NOT NULL DEFAULT "Random",
    "text" TEXT NOT NULL,
    "source" TEXT DEFAULT "",
    "grade" INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY("id" AUTOINCREMENT));
  ''';

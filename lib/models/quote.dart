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

  QuoteModel.fromMap(Map<String, dynamic> result)
      : id = result['id'] as int?,
        locale = result['locale'] as String?,
        origin = result['origin'] as String?,
        theme = result['theme'] as String?,
        level = result['level'] as int?,
        text = result['text'] as String?,
        source = result['source'] as String?,
        grade = result['grade'] as int?;

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

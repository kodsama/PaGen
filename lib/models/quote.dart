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
      'grade': grade ?? 0,
    };
  }

  QuoteModel.fromMap(Map<String, dynamic> result)
      : id = _readInt(result['id']),
        locale = result['locale'] as String?,
        origin = result['origin'] as String?,
        theme = result['theme'] as String?,
        level = _readInt(result['level']),
        text = result['text'] as String?,
        source = result['source'] as String?,
        grade = _readInt(result['grade']);

  static int? _readInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  QuoteModel copyWith({
    int? id,
    String? locale,
    String? origin,
    int? level,
    String? theme,
    String? text,
    String? source,
    int? grade,
  }) {
    return QuoteModel(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      origin: origin ?? this.origin,
      level: level ?? this.level,
      theme: theme ?? this.theme,
      text: text ?? this.text,
      source: source ?? this.source,
      grade: grade ?? this.grade,
    );
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

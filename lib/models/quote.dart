
class QuoteModel {
  int id;
  String origin;
  int level;
  String theme;
  String text;
  String source;

  QuoteModel({
    this.id,
    this.origin,
    this.level,
    this.theme,
    this.text,
    this.source
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'origin': origin,
      'level': level,
      'theme': theme,
      'text': text,
      'source': source,
    };
  }

  QuoteModel.fromMap(Map<String, dynamic> result) {
    this.id = result['id'];
    this.origin = result['origin'];
    this.theme = result['theme'];
    this.level = result['level'];
    this.text = result['text'];
    this.source = result['source'];
  }

  @override
  String toString() {
    return 'QuoteModel{id: $id, orig:$origin, lvl: $level, theme: $theme, text: $text, src: $source}';
  }
}

String orderModelCreateString = '''
  CREATE TABLE quotes(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    origin TEXT NOT NULL,
    theme TEXT NOT NULL,
    level INT NOT NULL,
    text TEXT NOT NULL,
    source TEXT)
  ''';

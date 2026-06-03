import 'package:flutter_test/flutter_test.dart';

import 'package:pagen/models/quote.dart';

void main() {
  group('QuoteModel', () {
    test('round-trips through toMap/fromMap', () {
      final quote = QuoteModel(
        id: 1,
        locale: 'en',
        origin: 'Tester',
        level: 2,
        theme: 'Kitchen',
        text: 'Do the dishes.',
        source: 'Custom',
        grade: 3,
      );

      final restored = QuoteModel.fromMap(quote.toMap());

      expect(restored.id, quote.id);
      expect(restored.locale, quote.locale);
      expect(restored.origin, quote.origin);
      expect(restored.level, quote.level);
      expect(restored.theme, quote.theme);
      expect(restored.text, quote.text);
      expect(restored.source, quote.source);
      expect(restored.grade, quote.grade);
    });

    test('copyWith updates grade for live UI refresh', () {
      final quote = QuoteModel(id: 1, text: 'Hi', grade: 2);
      expect(quote.copyWith(grade: 3).grade, 3);
    });
  });
}

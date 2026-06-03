import 'package:flutter_test/flutter_test.dart';
import 'package:pagen/models/quote.dart';

void main() {
  test('copyWith bumps grade for thumb actions', () {
    final quote = QuoteModel(id: 5, text: 'Test', grade: 0);
    expect(quote.copyWith(grade: 1).grade, 1);
    expect(quote.copyWith(grade: -1).grade, -1);
    expect(quote.copyWith(grade: 2).grade, 2);
  });

  test('fromMap reads integer grade from sqlite-style values', () {
    final quote = QuoteModel.fromMap({
      'id': 1,
      'text': 'Hi',
      'grade': 3,
      'level': 1,
      'theme': 'Random',
    });
    expect(quote.grade, 3);
  });
}

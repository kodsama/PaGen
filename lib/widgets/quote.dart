import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../states.dart';
import '../models/quote.dart';

class QuoteWidget extends StatelessWidget {
  final Widget child;

  const QuoteWidget({super.key, required this.child});

  void onPressed(BuildContext context) {
    MyStatefulWidget.of(context).pickQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: postItColor,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: postItColor,
            foregroundColor: Colors.black,
            elevation: 0,
            shape: const RoundedRectangleBorder(),
          ),
          onPressed: () {
            onPressed(context);
          },
          child: child,
        ),
      ),
    );
  }
}

class QuoteText extends StatefulWidget {
  const QuoteText({super.key});

  @override
  State<QuoteText> createState() => QuoteTextState();
}

class QuoteTextState extends State<QuoteText> {
  QuoteModel? quote;
  double fontSize = 20.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MyStatefulWidgetState data = MyStatefulWidget.of(context);
    quote = data.quote;
  }

  @override
  Widget build(BuildContext context) {
    final QuoteModel currentQuote = quote ??
        QuoteModel(
          text: FlutterI18n.translate(context, 'states.welcome'),
          source: '',
        );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(
          '${currentQuote.text}',
          style: TextStyle(fontSize: fontSize, color: Colors.black),
          minFontSize: 12,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 60), // Spacing
        Align(
          alignment: Alignment.centerRight,
          child: AutoSizeText(
            '- ${currentQuote.source}',
            style: TextStyle(fontSize: fontSize - 5, color: Colors.grey),
            minFontSize: 12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 10), // Spacing
        Align(
          alignment: Alignment.centerRight,
          child: AutoSizeText(
            _getGradeText(currentQuote.grade),
            style: TextStyle(fontSize: fontSize, color: Colors.grey),
            minFontSize: 12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _getGradeText(int? grade) {
    if (grade == null) {
      return '';
    }
    if (grade > 0) {
      return '👍 $grade';
    }
    if (grade < 0) {
      return '👎 $grade';
    }
    return '🤷 $grade';
  }
}
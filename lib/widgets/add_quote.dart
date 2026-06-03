import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../states.dart';
import '../db_helper.dart';
import '../models/quote.dart';
import '../utils/app_logger.dart';

class AddQuoteWidget extends StatefulWidget {
  const AddQuoteWidget({super.key});

  @override
  State<AddQuoteWidget> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuoteWidget> {
  late String paTheme;
  late int paScale;
  late List<String> paScales;
  late List<String> paThemes;
  final TextEditingController etQuote = TextEditingController();
  final TextEditingController etOrigin = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyStatefulWidgetState data = MyStatefulWidget.of(context);
    paScales = data.paScales;
    paThemes = data.paThemes;
    paScale = paScales.indexOf(paScales[1]);
    paTheme = paThemes[0];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(context, 'add_quote.add'),
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 30),
          TextField(
            controller: etQuote,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: FlutterI18n.translate(context, 'add_quote.quote'),
              hintText: FlutterI18n.translate(context, 'add_quote.quote_hint'),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: etOrigin,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusColor: Colors.red,
              labelText: FlutterI18n.translate(context, 'add_quote.src'),
              hintText: FlutterI18n.translate(context, 'add_quote.src_hint'),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, 'add_quote.pa_scale'),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  DropdownButton<String>(
                    value: paScales[paScale],
                    items:
                        paScales.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    // icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.orange),
                    underline: Container(),
                    onChanged: (String? value) {
                      if (value != null) paScale = paScales.indexOf(value);
                    },
                  ),
                ],
              ),
              SizedBox(width: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, 'add_quote.theme'),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  DropdownButton<String>(
                    value: paTheme,
                    items:
                        paThemes.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    // icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.orange),
                    underline: Container(),
                    onChanged: (String? value) {
                      if (value != null) paTheme = value;
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: const BorderSide(color: Colors.white),
              ),
            ),
            onPressed: () {
              final Locale currLocale = Localizations.localeOf(context);
              _saveQuote(etQuote.text, etOrigin.text, currLocale.languageCode,
                  paScale, paTheme);
            },
            child: Image.asset(
              'assets/images/trollface.png',
              fit: BoxFit.contain,
              height: 80,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveQuote(
      String quote, String origin, String lang, int pa, String theme) async {
    await DatabaseHelper.instance.insertQuote(QuoteModel(
      text: quote,
      origin: origin,
      locale: lang,
      level: pa,
      theme: theme,
      source: 'Custom',
      grade: 0,
    ));
    AppLogger.info("Saved quote: '$quote' ($origin, $lang, level $pa, $theme)");
    if (!mounted) return;
    MyStatefulWidget.of(context).refreshQuotes();
    Navigator.pop(context, FlutterI18n.translate(context, 'add_quote.saved'));
  }
}

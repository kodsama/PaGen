import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../states.dart';
import '../db_helper.dart';
import '../models/quote.dart';

class AddQuoteWidget extends StatefulWidget {
  AddQuoteWidget({Key key}): super(key: key);

  @override
  _AddQuoteState createState() => _AddQuoteState();
}


class _AddQuoteState extends State<AddQuoteWidget> {
  String paTheme;
  int paScale;
  List<String> paScales;
  List<String> paThemes;
  TextEditingController etQuote = new TextEditingController();
  TextEditingController etOrigin = new TextEditingController();

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
        children: <Widget> [
          SizedBox(height: 10),
          Text(FlutterI18n.translate(context, 'add_quote.add'),
            style: TextStyle(fontSize: 20.0,),
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
            children: <Widget> [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Text(FlutterI18n.translate(context, 'add_quote.pa_scale'),
                      style: TextStyle(fontSize: 12.0,),
                    ),
                    DropdownButton<String>(
                      value: paScales[paScale],
                      items: paScales
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      // icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                        color: Colors.orange
                      ),
                      underline: Container(),
                      onChanged:  (String value) {
                        paScale = paScales.indexOf(value);
                      },
                    ),
                ],
              ),
              SizedBox(width: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Text(FlutterI18n.translate(context, 'add_quote.theme'),
                    style: TextStyle(fontSize: 12.0,),
                  ),
                  DropdownButton<String>(
                    value: paTheme,
                    items: paThemes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    // icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.orange
                    ),
                    underline: Container(),
                    onChanged:  (String value) {paTheme = value;},
                  ),
                ],
              ),
           ],
          ),
          SizedBox(height: 20),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(color: Colors.white)
            ),
            color: Colors.white,
            onPressed: () async {
              _saveQuote(etQuote.text, etOrigin.text, paScale, paTheme);
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

_saveQuote(String quote, String origin, int pa, String theme) async {
  DatabaseHelper.instance.insertQuote(QuoteModel(
      text: quote,
      origin: origin,
      level: pa,
      theme: theme,
      source: 'Custom',
      grade: 0,
  ));
  print('Saved: \'$quote\', \'$origin\', $pa, $theme');
  MyStatefulWidget.of(context).refreshQuotes();
  Navigator.pop(context, FlutterI18n.translate(context, 'add_quote.saved'));
  }
}
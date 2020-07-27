import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'models/quote.dart';
import 'db_helper.dart';

const Map<int, Color> color = {
  50:Color.fromRGBO(4,131,184, .1),
  100:Color.fromRGBO(4,131,184, .2),
  200:Color.fromRGBO(4,131,184, .3),
  300:Color.fromRGBO(4,131,184, .4),
  400:Color.fromRGBO(4,131,184, .5),
  500:Color.fromRGBO(4,131,184, .6),
  600:Color.fromRGBO(4,131,184, .7),
  700:Color.fromRGBO(4,131,184, .8),
  800:Color.fromRGBO(4,131,184, .9),
  900:Color.fromRGBO(4,131,184, 1),
};
const MaterialColor appColor = MaterialColor(0xFFEFF294, color);
const MaterialColor postItColor = MaterialColor(0xFFF2EFBD, color);

final String appShortName = 'PAGen';
final String appLongName = 'Passive Agressive Generator';

class MyStatefulWidget extends StatefulWidget {
  final Widget child;

  const MyStatefulWidget({Key key, @required this.child}) : super(key: key);

  static MyStatefulWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>().data;
  }

  @override
  State<StatefulWidget> createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<QuoteModel> _quotes = [];
  QuoteModel _quote;
  double _paScale = 1;
  String _paTheme = 'Random';
  final List<String> _paThemes = [
    "Random",
    "Public",
    "Laundry",
    "Kitchen",
    "Custom"
    ];
  final List<String> _paScales = [
    "Passive",
    "Passive-agressive",
    "Agressive",
  ];

  QuoteModel get quote => _quote;
  double get paScale => _paScale;
  String get paTheme => _paTheme;
  List<String> get paThemes => _paThemes;
  List<String> get paScales => _paScales;

  void updatePaScale(double value) {
    _paScale = value;
  }
  void updatePaTheme(String theme) {
    _paTheme = theme;
  }

  void refreshQuotes() async {
    var results = await DatabaseHelper.instance.retrieveAllQuotes();
    for (int i = 0; i < results.length; i++) {
      _quotes.add(QuoteModel.fromMap(results[i]));
    }
  }

  void pickQuote() async {
    if (_quotes.length == 0) {
      await refreshQuotes();
    }
    // Get sublist of quotes based on level and then topic with length checks
    List<QuoteModel> _byTheme = [];
    List<QuoteModel> _byLvl = [];
    _byLvl = _quotes.where((e) => e.level == _paScale).toList();
    if (_byLvl.length == 0) { // Not enough quotes, use full list
      _byTheme = _quotes;
    } else {
      if (_paTheme == 'Random') {
        _byTheme = _byLvl; // Doesn't matter which theme we use
      } else {
        _byTheme = _byLvl.where((e) => e.theme == _paTheme).toList();
      }
      if (_byTheme.length == 0) _byTheme = _byLvl; // Not enough, use level
    }
    setState(() {
      _quote = _byTheme[Random().nextInt(_byTheme.length)];
    });
  }

  void incrementQuoteGrade(QuoteModel quote, int increment) {
    String toast;
    if (quote != null) {
      DatabaseHelper.instance.gradeQuote(quote, increment);
      toast = FlutterI18n.translate(context, 'states.success');
    } else {
      print('Quote is NULL!');
      toast = FlutterI18n.translate(context, 'states.fail');
    }
    Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 15.0
    );
  }

  @override
  Widget build(BuildContext context) {
    // pickQuote(); // Comment out to load a random quote at startup
    return MyInheritedWidget(
      child: widget.child,
      data: this,
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final MyStatefulWidgetState data;

  MyInheritedWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
import 'package:flutter/material.dart';
import 'dart:math';

import 'db_handler.dart';

Map<int, Color> color = {
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
final MaterialColor appColor = MaterialColor(0xFFEFF294, color);
final MaterialColor postItColor = MaterialColor(0xFFF2EFBD, color);

final String appShortName = 'PAGen';
final String appLongName = 'Passive Agressive GENerator';

class MyStatefulWidget extends StatefulWidget {
  final Widget child;

  const MyStatefulWidget({Key key, @required this.child}) : super(key: key);

  static MyStatefulWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>().data;
  }

  @override
  State<StatefulWidget> createState() {
    return MyStatefulWidgetState();
  }
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<QuoteModel> _quotes = [];
  String _quote = 'Nope';//_quotes[Random().nextInt(_quotes.length)];
  int _counterValue = 0;

  String get quote => _quote;
  int get counterValue => _counterValue;

  void pickRandomQuote() async {
    if (_quotes.length == 0) {
      var results = await DatabaseHandler.instance.retrieveAllQuotes();
      int count = results.length;
      for (int i = 0; i < count; i++) {
        _quotes.add(QuoteModel.fromMap(results[i]));
      }
    }
    setState(() {
      QuoteModel chosen = _quotes[Random().nextInt(_quotes.length)];
      _quote = chosen.text;
    });
  }

  void addCounterBy1() {
    setState(() {
      _counterValue += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
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
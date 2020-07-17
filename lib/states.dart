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
final String appLongName = 'Passive Agressive Generator';

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
  String _quote = 'Tap here to load a note';
  String _source = '';
  double _pa_scale = 1;
  String _pa_theme = 'Random';

  String get quote => _quote;
  String get source => _source;
  double get pa_scale => _pa_scale;
  String get pa_theme => _pa_theme;

  void updatePaScale(double value) {
    _pa_scale = value;
  }
  void updatePaTheme(String theme) {
    _pa_theme = theme;
  }

  void pickQuote() async {
    if (_quotes.length == 0) {
      var results = await DatabaseHandler.instance.retrieveAllQuotes();
      int count = results.length;
      for (int i = 0; i < count; i++) {
        _quotes.add(QuoteModel.fromMap(results[i]));
      }
    }
    // Get sublist of quotes based on level and then topic with length checks
    List<QuoteModel> _byTheme = [];
    List<QuoteModel> _byLvl = [];
    _byLvl = _quotes.where((e) => e.level == _pa_scale).toList();
    if (_byLvl.length == 0) { // Not enough quotes, use full list
      _byTheme = _quotes;
    } else {
      if (_pa_theme == 'Random') {
        _byTheme = _byLvl; // Doesn't matter which theme we use
      } else {
        _byTheme = _byLvl.where((e) => e.theme == _pa_theme).toList();
      }
      if (_byTheme.length == 0) _byTheme = _byLvl; // Not enough, use level
    }
    QuoteModel chosen = _byTheme[Random().nextInt(_byTheme.length)];
    setState(() {
      _quote = chosen.text;
      _source = chosen.source;
    });
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
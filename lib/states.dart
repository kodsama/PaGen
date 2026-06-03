import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'models/quote.dart';
import 'db_helper.dart';
import 'utils/app_logger.dart';

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

  const MyStatefulWidget({super.key, required this.child});

  static MyStatefulWidgetState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!
        .data;
  }

  @override
  State<MyStatefulWidget> createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<QuoteModel> _quotes = [];
  QuoteModel? _quote;
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

  QuoteModel? get quote => _quote;
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

  Future<void> refreshQuotes() async {
    final results = await DatabaseHelper.instance.retrieveAllQuotes();
    for (int i = 0; i < results.length; i++) {
      _quotes.add(QuoteModel.fromMap(results[i]));
    }
  }

  void pickQuote() async {
    if (_quotes.isEmpty) {
      await refreshQuotes();
    }
    // Get sublist of quotes based on level and then topic with length checks
    List<QuoteModel> byTheme = [];
    List<QuoteModel> byLvl = [];
    byLvl = _quotes.where((e) => e.level == _paScale).toList();
    if (byLvl.isEmpty) {
      // Not enough quotes, use full list
      byTheme = _quotes;
    } else {
      if (_paTheme == 'Random') {
        byTheme = byLvl; // Doesn't matter which theme we use
      } else {
        byTheme = byLvl.where((e) => e.theme == _paTheme).toList();
      }
      if (byTheme.isEmpty) byTheme = byLvl; // Not enough, use level
    }
    if (byTheme.isEmpty) return;
    setState(() {
      _quote = byTheme[Random().nextInt(byTheme.length)];
    });
  }

  void incrementQuoteGrade(QuoteModel? quote, int increment) {
    String toast;
    if (quote != null) {
      DatabaseHelper.instance.gradeQuote(quote, increment);
      toast = FlutterI18n.translate(context, 'states.success');
    } else {
      AppLogger.warning('Attempted to grade a null quote.');
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

  const MyInheritedWidget({
    super.key,
    required super.child,
    required this.data,
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
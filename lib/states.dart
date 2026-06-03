import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'models/quote.dart';
import 'db_helper.dart';
import 'theme/app_theme.dart';
import 'utils/app_logger.dart';

// Legacy swatch used by splash until fully migrated.
const MaterialColor appColor = MaterialColor(0xFFFFE566, <int, Color>{
  50: AppColors.lemon,
  100: AppColors.lemon,
  200: AppColors.lemon,
  300: AppColors.lemon,
  400: AppColors.lemon,
  500: AppColors.lemon,
  600: AppColors.lemon,
  700: AppColors.lemon,
  800: AppColors.lemon,
  900: AppColors.lemon,
});

/// Post-it background for the quote area (legacy name kept for quote widget).
const Color postItColor = AppColors.postIt;

const String appShortName = 'PAGen';
const String appLongName = 'Passive Agressive Generator';

class MyStatefulWidget extends StatefulWidget {
  final Widget child;

  const MyStatefulWidget({super.key, required this.child});

  static MyStatefulWidgetState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!
        .state;
  }

  /// Subscribe to quote / grade changes (use in screen build methods).
  static MyInheritedWidget watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  }

  @override
  State<MyStatefulWidget> createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<QuoteModel> _quotes = [];
  QuoteModel? _quote;
  int _paLevel = 1;
  String _paTheme = 'Random';
  int _quoteRevision = 0;

  final List<String> _paThemes = [
    'Random',
    'Public',
    'Laundry',
    'Kitchen',
    'Custom',
  ];

  final List<String> _paScales = [
    'Passive',
    'Passive-agressive',
    'Agressive',
  ];

  QuoteModel? get quote => _quote;
  int get quoteRevision => _quoteRevision;
  int get paLevel => _paLevel;
  double get paScale => _paLevel.toDouble();
  String get paTheme => _paTheme;
  List<String> get paThemes => _paThemes;
  List<String> get paScales => _paScales;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    await refreshQuotes();
    if (_quote == null && mounted) {
      await pickQuote();
    }
  }

  void updatePaLevel(int level) {
    if (_paLevel == level) return;
    setState(() => _paLevel = level);
    pickQuote();
  }

  void updatePaScale(double value) {
    updatePaLevel(value.round());
  }

  void updatePaTheme(String theme) {
    if (_paTheme == theme) return;
    setState(() => _paTheme = theme);
    pickQuote();
  }

  Future<void> refreshQuotes() async {
    final results = await DatabaseHelper.instance.retrieveAllQuotes();
    if (!mounted) return;
    setState(() {
      _quotes
        ..clear()
        ..addAll(results.map(QuoteModel.fromMap));
    });
  }

  Future<void> pickQuote() async {
    if (_quotes.isEmpty) {
      await refreshQuotes();
    }
    if (_quotes.isEmpty || !mounted) return;

    List<QuoteModel> pool = _quotes.where((e) => e.level == _paLevel).toList();
    if (pool.isEmpty) pool = List<QuoteModel>.from(_quotes);

    if (_paTheme != 'Random') {
      final themed = pool.where((e) => e.theme == _paTheme).toList();
      if (themed.isNotEmpty) pool = themed;
    }

    _publishQuote(pool[Random().nextInt(pool.length)]);
  }

  void _publishQuote(QuoteModel updated) {
    setState(() {
      _quote = updated;
      _quoteRevision++;
      final index = _quotes.indexWhere((q) => q.id == updated.id);
      if (index >= 0) {
        _quotes[index] = updated;
      }
    });
  }

  /// Bump the visible note's score (+1 / -1) and refresh the card immediately.
  void bumpQuoteGrade(int increment) {
    final current = _quote;
    if (current?.id == null) {
      AppLogger.warning('Attempted to grade without a loaded quote.');
      _showToast(FlutterI18n.translate(context, 'states.fail'));
      return;
    }

    final newGrade = (current!.grade ?? 0) + increment;
    final updated = current.copyWith(grade: newGrade);
    _publishQuote(updated);
    _showToast(FlutterI18n.translate(context, 'states.success'));

    unawaited(_persistGradeQuietly(updated));
  }

  Future<void> _persistGradeQuietly(QuoteModel quote) async {
    try {
      await DatabaseHelper.instance.persistQuoteGrade(quote);
    } catch (e, st) {
      AppLogger.warning(
        'Failed to persist quote grade (UI already updated)',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.ink,
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      quote: _quote,
      quoteRevision: _quoteRevision,
      paLevel: _paLevel,
      paTheme: _paTheme,
      state: this,
      child: widget.child,
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final QuoteModel? quote;
  final int quoteRevision;
  final int paLevel;
  final String paTheme;
  final MyStatefulWidgetState state;

  const MyInheritedWidget({
    super.key,
    required this.quote,
    required this.quoteRevision,
    required this.paLevel,
    required this.paTheme,
    required this.state,
    required super.child,
  });

  int get displayGrade => quote?.grade ?? 0;

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return quoteRevision != oldWidget.quoteRevision ||
        quote != oldWidget.quote ||
        displayGrade != oldWidget.displayGrade ||
        paLevel != oldWidget.paLevel ||
        paTheme != oldWidget.paTheme;
  }
}

import 'package:flutter/material.dart';
import 'bar_settings.dart';
import 'bar_quote.dart';
import 'bar_bottom.dart';

class BuildPages extends StatelessWidget {
  BuildPages();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SettingsBar(),
        QuoteBar(),
        BottomBar(),
      ], // children of Column
    ); // Column
  }
}

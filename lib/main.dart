import 'package:flutter/material.dart';

import 'states.dart';
import 'appbar.dart';
import 'settings.dart';
import 'quote.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appShortName,
      theme: ThemeData(
        primarySwatch: appColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: appLongName),
      ); // MaterialApp
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  final double app_bar_height = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(this.title, this.app_bar_height),
      body: MyStatefulWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Settings(),
            QuoteContainer(
              child: QuoteText(),
            ),
          ],
        ),
      ),
    );
  }
}

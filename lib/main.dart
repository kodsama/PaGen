import 'package:flutter/material.dart';
import 'bar_app.dart';
import 'pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAGen',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Passive Agressive GENerator'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final double app_bar_height = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(this.title, this.app_bar_height),
      body: BuildPages(),
    ); // Scaffold
  }
}

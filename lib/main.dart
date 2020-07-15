import 'package:flutter/material.dart';
import 'bar_app.dart';
import 'pages.dart';


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


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appShortName,
      theme: ThemeData(
        primarySwatch: appColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: appLongName),
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

import 'package:flutter/material.dart';
//import 'package:unicorndial/unicorndial.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../states.dart';
import '../widgets/appbar.dart';
import '../widgets/settings.dart';
import '../widgets/quote.dart';
import '../widgets/drawer.dart';
import '../models/quote.dart';
import 'add_quote.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuoteModel quote;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyStatefulWidgetState data = MyStatefulWidget.of(context);
    quote = data.quote;
  }

  @override
  Widget build(BuildContext context) {
    switch (MediaQuery.of(context).orientation) {
      case Orientation.landscape:
        return _landscapeHome(context);
      case Orientation.portrait:
      default:
        return _portraitHome(context);
    }
  }

  Scaffold _portraitHome(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SettingsWidget(),
          QuoteWidget(child: QuoteText()),
        ],
      ),
      //floatingActionButton: _floatButtons(
      //  context,
      //  UnicornOrientation.VERTICAL,
      //  ),
    );
  }

  Scaffold _landscapeHome(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          QuoteWidget(child: QuoteText()),
        ],
      ),
      //floatingActionButton: _floatButtons(
      //  context,
      //  UnicornOrientation.HORIZONTAL,
      //  ),
    );
  }
/*
  UnicornDialer _floatButtons(BuildContext context, int orientation) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: FlutterI18n.translate(context, 'home.add_quote'),
      currentButton: FloatingActionButton(
        heroTag: FlutterI18n.translate(context, 'home.add_quote'),
        backgroundColor: Colors.blueAccent,
        mini: true,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuoteScreen()));
        },
      )));

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: FlutterI18n.translate(context, 'home.thumb_up'),
      currentButton: FloatingActionButton(
        heroTag: FlutterI18n.translate(context, 'home.thumb_up_label'),
        backgroundColor: Colors.greenAccent,
        mini: true,
        child: Icon(Icons.thumb_up),
        onPressed: () {
          MyStatefulWidget.of(context).incrementQuoteGrade(quote, 1);
        },
      )));

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: FlutterI18n.translate(context, 'home.thumb_down'),
      currentButton: FloatingActionButton(
        heroTag: FlutterI18n.translate(context, 'home.thumb_down_label'),
        backgroundColor: Colors.redAccent,
        mini: true,
        child: Icon(Icons.thumb_down),
        onPressed: () {
          MyStatefulWidget.of(context).incrementQuoteGrade(quote, -1);
        },
      )));

    return UnicornDialer(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
      parentButtonBackground: Colors.redAccent,
      orientation: orientation,
      parentButton: Icon(Icons.all_inclusive),
      childButtons: childButtons
      );
  }
*/
}

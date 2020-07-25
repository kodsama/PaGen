import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../widgets/settings.dart';
import '../widgets/quote.dart';
import 'add_quote.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SettingsWidget(),
          QuoteWidget(child: QuoteText()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuoteScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuoteScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

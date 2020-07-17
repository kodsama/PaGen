import 'package:flutter/material.dart';

import 'states.dart';
import 'appbar.dart';
import 'settings.dart';
import 'quote.dart';
import 'db_handler.dart';

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

  // FIXME: remove _pre_populate_quotes_db
  void _pre_populate_quotes_db() async {
    DatabaseHandler.instance.removeDatabase();
    DatabaseHandler.instance.insertQuote(
      QuoteModel(
        theme: 'Public',
        level: 1,
        text: 'Love without sacrifice is like theft', source: 'Nassim Nicholas Taleb')
    );
    DatabaseHandler.instance.insertQuote(
      QuoteModel(
        theme: 'Random',
        level: 2,
        text: 'When introverts are in conflict with each other...it may require a map in order to follow all the silences, nonverbal cues and passive-aggressive behaviors!', source: 'Adam S. McHugh')
    );
    DatabaseHandler.instance.insertQuote(
      QuoteModel(
        theme: 'Random',
        level: 3,
        text: 'Anger\'s like a battery that leaks acid right out of me\n And it starts from the heart \'til it reaches my outer me', source: 'Criss Jami, Venus in Arms')
    );
    DatabaseHandler.instance.insertQuote(
      QuoteModel(
        theme: 'Random',
        level: 3,
        text: 'Lingering, bottled-up anger never reveals the \'true colors\' of an individual. It, on the contrary, becomes all mixed up, rotten, confused, forms a highly combustible, chemical compound then explodes as something foreign, something very different than one\'s natural self.', source: 'Criss Jami, Healology')
    );
    DatabaseHandler.instance.insertQuote(
      QuoteModel(
        theme: 'Random',
        level: 3,
        text: 'To let friendship die away by negligence and silence is certainly not wise. It is voluntarily to throw away one of the greatest comforts of this weary pilgrimage." ~Samuel Johnson', source: 'Edward M. Hallowell')
    );
    DatabaseHandler.instance.insertQuote(
      QuoteModel(
        theme: 'Kitchen',
        level: 4,
        text: 'To let friendship die away by negligence and silence is certainly not wise. It is voluntarily to throw away one of the greatest comforts of this weary pilgrimage." ~Samuel Johnson', source: 'Edward M. Hallowell')
    );
    DatabaseHandler.instance.insertQuote(
      QuoteModel(
        theme: 'Random',
        level: 5,
        text: 'Lingering, bottled-up anger never reveals the \'true colors\' of an individual. It, on the contrary, becomes all mixed up, rotten, confused, forms a highly combustible, chemical compound then explodes as something foreign, something very different than one\'s natural self.', source: 'Criss Jami, Healology')
    );
    DatabaseHandler.instance.insertQuote(
      QuoteModel(
        theme: 'Random',
        level: 6,
        text: 'Fuck you!', source: 'You')
    );
    DatabaseHandler.instance.insertQuote(
      QuoteModel(
        theme: 'Random',
        level: 6,
        text: 'Fuck you tons!', source: 'You again')
    );
  }

  @override
  Widget build(BuildContext context) {
    _pre_populate_quotes_db();
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

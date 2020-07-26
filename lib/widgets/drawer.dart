import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../states.dart';
import '../screens/onboarding.dart';
import '../screens/add_quote.dart';
import '../models/quote.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  QuoteModel quote;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyStatefulWidgetState data = MyStatefulWidget.of(context);
    quote = data.quote;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 80.0,
            child: DrawerHeader(
              child: Text('Omg, you found the god mode 😱'),
              decoration: BoxDecoration(
                color: appColor,
              ),
            ),
          ),
          ListTile(
            title: Text('View demo again 👶'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => OnboardScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Drop a 💩'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AddQuoteScreen()),
              );
            },
          ),
          ListTile(
            title: Text('This 💩rocks! 👍'),
            onTap: () {
              MyStatefulWidget.of(context).incrementQuoteGrade(quote, 1);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('This 💩sucks! 👎'),
            onTap: () {
              MyStatefulWidget.of(context).incrementQuoteGrade(quote, -1);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Buy a cup of 🍵'),
            onTap: () {
              // Navigator.pop(context);
              _launchBuyMeCoffeeURL();
            },
          ),
        ],
      ),
    );
  }

  _launchBuyMeCoffeeURL() async {
    const String url = 'https://www.buymeacoffee.com/kodsama';
    WidgetsFlutterBinding.ensureInitialized();
    await launch(url, forceWebView: true, enableJavaScript: true);
    // if (await canLaunch(url)) {
    //   await launch(url, forceWebView: true);
    // } else {
    //   print('Could not buy 🍵 at $url');
    // }
  }
}

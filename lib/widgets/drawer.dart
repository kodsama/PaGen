import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../states.dart';
import '../screens/onboarding.dart';
import '../screens/add_quote.dart';
import '../models/quote.dart';
import '../utils/app_logger.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  QuoteModel? quote;

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
          SizedBox(
            height: 80.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: appColor,
              ),
              child: Text(FlutterI18n.translate(context, 'home.god_mode')),
            ),
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.view_demo')),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => OnboardScreen()),
              );
            },
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.add_quote')),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => AddQuoteScreen()),
              );
            },
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.thumb_up')),
            onTap: () {
              MyStatefulWidget.of(context).incrementQuoteGrade(quote, 1);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.thumb_down')),
            onTap: () {
              MyStatefulWidget.of(context).incrementQuoteGrade(quote, -1);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.buy_tea')),
            onTap: () {
              // Navigator.pop(context);
              _launchBuyMeCoffeeURL();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _launchBuyMeCoffeeURL() async {
    final Uri url = Uri.parse('https://www.buymeacoffee.com/kodsama');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      AppLogger.warning('Could not open Buy Me a Coffee URL: $url');
    }
  }
}

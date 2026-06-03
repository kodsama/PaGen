import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../widgets/settings.dart';
import '../widgets/quote.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    switch (MediaQuery.of(context).orientation) {
      case Orientation.landscape:
        return _landscapeHome(context);
      case Orientation.portrait:
        return _portraitHome(context);
    }
  }

  Scaffold _portraitHome(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SettingsWidget(),
          QuoteWidget(child: QuoteText()),
        ],
      ),
    );
  }

  Scaffold _landscapeHome(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          QuoteWidget(child: QuoteText()),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'states.dart';
import 'screens/splash.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget(
      child: MaterialApp(
        title: appShortName,
        theme: ThemeData(
          primarySwatch: appColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

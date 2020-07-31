import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'onboarding.dart';
import 'home.dart';
import '../states.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with
TickerProviderStateMixin  {
  Locale appLanguage;
  AnimationController controller;
  Animation<double> animation;

  // Load quotes while the splashscreen is ongoing
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyStatefulWidget.of(context).refreshQuotes();
  }

  // Init i18n language detection
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        appLanguage = FlutterI18n.currentLocale(context);
      });
    });
    Timer(
      Duration(milliseconds: 1500),
      () => checkFirstSeen(),
    );
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn
    );
    controller.forward();
  }

  changeLanguage() async {
    appLanguage =
        appLanguage.languageCode == 'en' ? Locale('fr') : Locale('en');
    await FlutterI18n.refresh(context, appLanguage);
    setState(() {});
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomeScreen()));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnboardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: FadeTransition(
        opacity: animation,
        child: Center(
          child: Image.asset(
            'assets/images/trollface.png',
            fit: BoxFit.contain,
            height: 250,
          ),
        ),
      ),
    );
  }
}

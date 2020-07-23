import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'onboarding.dart';
import 'home.dart';
import '../states.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with
TickerProviderStateMixin  {
  AnimationController controller;
  Animation<double> animation;

  // Load quotes while the splashscreen is ongoing
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyStatefulWidget.of(context).refreshQuotes();
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
  void initState() {
    super.initState();
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

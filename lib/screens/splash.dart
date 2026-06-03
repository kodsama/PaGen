import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'onboarding.dart';
import 'home.dart';
import '../states.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Locale? appLanguage;
  late AnimationController controller;
  late Animation<double> animation;

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
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  Future<void> changeLanguage() async {
    appLanguage = appLanguage?.languageCode == 'en'
        ? const Locale('fr')
        : const Locale('en');
    await FlutterI18n.refresh(context, appLanguage);
    setState(() {});
  }

  Future<void> checkFirstSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool seen = prefs.getBool('seen') ?? false;
    if (!mounted) return;

    if (seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (context) => const HomeScreen()));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (context) => const OnboardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lemon,
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

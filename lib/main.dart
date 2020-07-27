import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'states.dart';
import 'screens/splash.dart';

void main() {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      useCountryCode: false,
      fallbackFile: 'en',
      basePath: 'assets/locales',
      // forcedLocale: Locale('fr'),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  flutterI18nDelegate.load(null);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(App(flutterI18nDelegate));
}

class App extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  App(this.flutterI18nDelegate);

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
        localizationsDelegates: [
          flutterI18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        builder: FlutterI18n.rootAppBuilder(),
      ),
    );
  }
}

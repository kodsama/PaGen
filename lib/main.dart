import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'states.dart';
import 'screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(App());
}

class App extends StatelessWidget {
  App();
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      useCountryCode: false,
      fallbackFile: 'en',
      basePath: 'assets/locales',
      // forcedLocale: Locale('fr'),
    ),
  );

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
        builder: FlutterI18n.rootAppBuilder(),
        supportedLocales: [
          Locale('en', ''),
          Locale('fr', ''),
          Locale('sv', ''),
        ],
        localizationsDelegates: [
          flutterI18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        home: SplashScreen(),
      ),
    );
  }
}

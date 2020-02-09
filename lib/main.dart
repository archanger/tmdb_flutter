import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies/router/router_generator.dart';
import 'package:movies/splash/splash_page.dart';
import 'package:movies/tools/constants.dart';

void main(List<String> arguments) {
  if (arguments.isNotEmpty) {
    constants.changeBaseURL(arguments.first);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB-Client',
      theme: tmdbTheme(context),
      onGenerateRoute: routerGenerator,
      home: SplashFactory().createPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('de', 'DE'),
        const Locale('ru', 'RU'),
      ],
    );
  }
}

ThemeData tmdbTheme(BuildContext context) {
  return Theme.of(context).copyWith(
    brightness: Brightness.dark,
    primaryColor: Color(0xff151F25),
    canvasColor: Color(0xff1D292E),
    scaffoldBackgroundColor: Color(0xff19272E),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
  );
}

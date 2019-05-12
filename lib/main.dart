import 'package:flutter/material.dart';
import 'package:movies/movies_list/movies_list_bloc.dart';
import 'package:movies/movies_list/movies_list_page.dart';
import 'package:movies/movies_list/movies_service.dart';
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
        title: 'Flutter Demo',
        theme: tmdbTheme(context),
        home: MoviesListPage(
          bloc: MoviesListBloc(
            service: MoviesService(),
          ),
        ));
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
        ),
  );
}

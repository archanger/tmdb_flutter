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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MoviesListPage(
          bloc: MoviesListBloc(
            service: MoviesService(),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:movies/movies_list/movies_list_bloc.dart';
import 'package:movies/movies_list/movies_list_page.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:movies/splash/splash_page.dart';

Route<dynamic> routerGenerator(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
      return MaterialPageRoute(
        builder: (context) => MoviesListPage(
          bloc: MoviesListBloc(
            service: MoviesService(),
          ),
        ),
      );
    default:
      return MaterialPageRoute(builder: (context) => SplashPage());
  }
}

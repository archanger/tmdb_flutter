import 'package:flutter/material.dart';
import 'package:movies/movie_details/movie_details_bloc.dart';
import 'package:movies/movie_details/movie_details_page.dart';
import 'package:movies/movies_list/movies_list_bloc.dart';
import 'package:movies/movies_list/movies_list_page.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:movies/providers/configuration_provider.dart';
import 'package:movies/splash/splash_page.dart';

Route<dynamic> routerGenerator(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
      return MaterialPageRoute(
        builder: (context) => MoviesListPage(
          bloc: MoviesListBloc(
            service: MoviesService(),
            configProvider: globalConfigProvider,
          ),
        ),
      );
    case '/details':
      try {
        var movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => MovieDetailsPage(
            bloc: MovieDetailsBloc(
              id: movieId,
              service: MoviesService(),
            ),
          ),
        );
      } catch (e) {
        print(e);
      }
      break;
    default:
      return MaterialPageRoute(builder: (context) => SplashPage());
  }
}

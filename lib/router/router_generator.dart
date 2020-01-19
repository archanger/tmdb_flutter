import 'package:flutter/material.dart';
import 'package:movies/movie_details/movie_details_page.dart';
import 'package:movies/movies_list/movies_list_page.dart';
import 'package:movies/splash/splash_page.dart';

Route<dynamic> routerGenerator(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
      return _home(settings);
      break;
    case '/details':
      return _details(settings);
      break;
    default:
      return MaterialPageRoute(
        builder: (context) => SplashFactory().createPage(),
      );
  }
}

Route<dynamic> _home(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) => MoviesListFactory().listPage(),
  );
}

Route<dynamic> _details(RouteSettings settings) {
  try {
    var movieId = settings.arguments as int;
    return MaterialPageRoute(
      builder: (context) => MovieDetailsPageFactory().movieDetailsPage(movieId: movieId),
    );
  } catch (e) {
    // TODO: add error page
    print(e);
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/helpers/base_query.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movies_result.dart';
import 'package:movies/tools/base_url_provider_mixin.dart';
import 'package:movies/tools/date_time_formatters.dart';

class UpcomingMoviesQuery extends BaseQuery {
  final String region;
  final String language;
  final String releaseDate;
  final int page;

  UpcomingMoviesQuery(
    this.releaseDate,
    this.page, {
    this.region = 'RU',
    this.language = 'ru',
  });

  @override
  String toString() => super.toString() + '&region=$region&language=$language&release_date.gte=$releaseDate&page=$page';
}

class MoviesService with BaseURLProviderMixin {
  Future<MoviesResult> fetchUpcomingMovies({int page = 1}) async {
    final query = UpcomingMoviesQuery(_gteDateString, page);
    final response = await http.get(_url(page).replace(query: query.toString()));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return MoviesResultDeserializer().parse(jsonBody);
    }

    return MoviesResult.empty();
  }

  Uri _url(int page) => Uri.parse(baseURL + '/discover/movie');

  String get _gteDateString {
    final now = DateTime.now();
    return DateTimeFormatters.tmdbDateFrom(now);
  }
}

class MoviesResultDeserializer {
  MoviesResult parse(Map<String, dynamic> body) => MoviesResult(
        body['page'],
        body['total_pages'],
        body['total_results'],
        (body['results'] as List).map((body) => MovieParser().parse(body)).toList(),
      );
}

class MovieParser {
  Movie parse(Map<String, dynamic> body) {
    return Movie(
      body['id'],
      body['title'],
      body['poster_path'],
      body['vote_average'],
      DateTime.parse(body['release_date'] as String),
    );
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/helpers/base_query.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movies_result.dart';
import 'package:movies/providers/configuration_provider.dart';
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
      final imageBaseUrl = ConfigurationProvider().configuration.imageConfiguration.baseUrl;
      return MoviesResultDeserializer(response.body, imageBaseUrl).parse();
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
  final Map<String, dynamic> map;
  final String baseUrl;

  MoviesResultDeserializer(
    String body,
    this.baseUrl,
  ) : this.map = json.decode(body);

  MoviesResult parse() => MoviesResult(
        map['page'],
        map['total_pages'],
        map['total_results'],
        (map['results'] as List).map((m) => _parseMovies(m)).toList(),
      );

  Movie _parseMovies(Map<String, dynamic> map) {
    return Movie(
      map['id'],
      map['title'],
      map['poster_path'] != null ? baseUrl + 'w185' + map['poster_path'] : null,
      map['vote_average'],
      DateTime.parse(map['release_date'] as String),
    );
  }
}

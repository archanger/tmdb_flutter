import 'dart:convert';

import 'package:movies/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/movies_result.dart';
import 'package:movies/models/serializers.dart';
import 'package:movies/tools/constants.dart';

class MoviesService {
  Future<List<Movie>> fetchUpcomingMovies() async {
    final response = await http.get(_url);
    if (response.statusCode == 200) {
      final movies = serializers.deserializeWith(
        MoviesResult.serializer,
        json.decode(response.body),
      );

      return movies.results.toList();
    }

    return [];
  }

  Uri get _url => Uri.parse(constants.baseURL + '/movie/upcoming?api_key=27f041b87264c855c1f8d198c9d73cfe');
}

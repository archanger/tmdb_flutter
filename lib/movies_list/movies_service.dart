import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/models/movies_result.dart';
import 'package:movies/models/serializers.dart';
import 'package:movies/tools/base_url_provider_mixin.dart';
import 'package:movies/tools/date_time_formatters.dart';

class MoviesService with BaseURLProviderMixin {
  Future<MoviesResult> fetchUpcomingMovies({int page = 1}) async {
    final response = await http.get(_url(page));
    if (response.statusCode == 200) {
      final result = serializers.deserializeWith(
        MoviesResult.serializer,
        json.decode(response.body),
      );

      return result;
    }

    return MoviesResult.empty();
  }

  Uri _url(int page) => Uri.parse(baseURL +
      '/discover/movie?api_key=27f041b87264c855c1f8d198c9d73cfe&region=RU&language=ru&release_date.gte=$_gteDateString&page=$page');

  String get _gteDateString {
    final now = DateTime.now();
    return DateTimeFormatters.tmdbDateFrom(now);
  }
}

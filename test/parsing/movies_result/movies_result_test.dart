import 'dart:io';

import 'package:movies/models/movie.dart';
import 'package:movies/models/movies_result.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:test/test.dart';

void main() {
  test('movies_result parsing', () async {
    final jsonString = File('parsing/movies_result/movies_result.json').readAsStringSync();

    final result = MoviesResultDeserializer(jsonString, '').parse();

    expect(
      result,
      MoviesResult(1, 1, 1, _fakeMovies()),
    );
  });
}

List<Movie> _fakeMovies() => [fakeMovie()];

Movie fakeMovie() => Movie(
      438674,
      'Закатать в асфальт',
      '/c8uwOiMa3sTBEpuXExsu6EGObIB.jpg',
      6.6,
      DateTime(2019, 4, 18),
    );

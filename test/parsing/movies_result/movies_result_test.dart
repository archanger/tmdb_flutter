import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movies_result.dart';
import 'package:movies/models/serializers.dart';
import 'package:test/test.dart';

import '../movie/movie_test.dart';

void main() {
  test('movies_result parsing', () async {
    final jsonString = File('parsing/movies_result/movies_result.json').readAsStringSync();

    final result = serializers.deserializeWith(
      MoviesResult.serializer,
      json.decode(jsonString),
    );

    expect(result, MoviesResult((b) => b.results = _fakeMovies()));
  });
}

ListBuilder<Movie> _fakeMovies() => ListBuilder([fakeMovie()]);

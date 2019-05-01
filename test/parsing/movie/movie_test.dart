import 'dart:convert';
import 'dart:io';

import 'package:movies/models/movie.dart';
import 'package:movies/models/serializers.dart';
import 'package:test/test.dart';

void main() {
  test('movie parsing', () async {
    final jsonString = File('parsing/movie/movie.json').readAsStringSync();

    final movie = serializers.deserializeWith(
      Movie.serializer,
      json.decode(jsonString),
    );

    expect(movie, fakeMovie());
  });
}

Movie fakeMovie() => Movie((b) => b.title = 'Закатать в асфальт');

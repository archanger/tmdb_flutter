import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:movies/models/movie.dart';

part 'movies_result.g.dart';

abstract class MoviesResult implements Built<MoviesResult, MoviesResultBuilder> {
  static Serializer<MoviesResult> get serializer => _$moviesResultSerializer;

  BuiltList<Movie> get results;

  MoviesResult._();
  factory MoviesResult([void Function(MoviesResultBuilder) updates]) = _$MoviesResult;
}

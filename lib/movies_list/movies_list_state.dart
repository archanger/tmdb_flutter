import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:movies/models/movie.dart';

part 'movies_list_state.g.dart';

abstract class MoviesListState implements Built<MoviesListState, MoviesListStateBuilder> {
  static Serializer<MoviesListState> get serializer => _$moviesListStateSerializer;

  BuiltList<Movie> get movies;
  bool get hasAnotherBatch;

  MoviesListState._();
  factory MoviesListState([void Function(MoviesListStateBuilder) updates]) = _$MoviesListState;
  factory MoviesListState.empty() {
    return MoviesListState((b) => b
      ..hasAnotherBatch = true
      ..movies = ListBuilder());
  }
}

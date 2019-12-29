import 'package:movies/models/movie.dart';

import 'package:equatable/equatable.dart';

class MoviesListState extends Equatable {
  final List<Movie> movies;
  final bool hasAnotherBatch;

  MoviesListState(this.movies, this.hasAnotherBatch);

  factory MoviesListState.empty() => MoviesListState(List(), true);

  @override
  List<Object> get props => [movies, hasAnotherBatch];
}

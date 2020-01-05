import 'package:movies/models/movie.dart';

import 'package:equatable/equatable.dart';

class MoviesResult extends Equatable {
  final int page;
  final int totalPages;

  final int totalResults;

  final List<Movie> results;

  const MoviesResult(
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  );

  factory MoviesResult.empty() => MoviesResult(1, 0, 0, []);

  @override
  List<Object> get props => [results];
}

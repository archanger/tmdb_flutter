import 'package:movies/models/movie.dart';

import 'package:equatable/equatable.dart';

class MoviesResult extends Equatable {
  final int page;
  final int totalPages; // @BuiltValueField(wireName: 'total_pages')

  final int totalResults; //@BuiltValueField(wireName: 'total_results')

  final List<Movie> results;

  MoviesResult(
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  );

  factory MoviesResult.empty() => MoviesResult(1, 0, 0, []);

  @override
  List<Object> get props => [results];
}

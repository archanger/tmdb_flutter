import 'package:equatable/equatable.dart';
import 'package:movies/models/movie_credit.dart';

class MovieDetail extends Equatable {
  final int id;
  final String title;
  final String storyLine;
  final String backdrop;
  final int runtime;
  final List<String> genres;
  final List<MovieCredit> credits;

  MovieDetail(
    this.id,
    this.title,
    this.storyLine,
    this.backdrop,
    this.genres,
    this.runtime,
    this.credits,
  );

  @override
  List<Object> get props => ['id'];
}

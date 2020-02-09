import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final int id;
  final String title;
  final String storyLine;
  final String backdrop;
  final int runtime;
  final List<String> genres;

  MovieDetail(this.id, this.title, this.storyLine, this.backdrop, this.genres, this.runtime);

  @override
  List<Object> get props => ['id'];
}

import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final int id;
  final String title;
  final String storyLine;
  final String poster;
  final List<String> genres;

  MovieDetail(this.id, this.title, this.storyLine, this.poster, this.genres);

  @override
  List<Object> get props => ['id'];
}

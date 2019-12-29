import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String posterPath; // @BuiltValueField(wireName: 'poster_path')
  final num voteAverage; // @BuiltValueField(wireName: 'vote_average')
  final DateTime releaseDate; // @BuiltValueField(wireName: 'release_date')

  Movie(
    this.id,
    this.title,
    this.posterPath,
    this.voteAverage,
    this.releaseDate,
  );

  @override
  List<Object> get props => [id];
}

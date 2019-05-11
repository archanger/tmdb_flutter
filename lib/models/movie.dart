import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {
  static Serializer<Movie> get serializer => _$movieSerializer;

  int get id;

  String get title;

  @nullable
  @BuiltValueField(wireName: 'poster_path')
  String get posterPath;

  @BuiltValueField(wireName: 'vote_average')
  num get voteAverage;

  @BuiltValueField(wireName: 'release_date')
  DateTime get releaseDate;

  Movie._();
  factory Movie([void Function(MovieBuilder) updates]) = _$Movie;
}

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {
  String get title;

  @nullable
  @BuiltValueField(wireName: 'poster_path')
  String get posterPath;

  Movie._();
  static Serializer<Movie> get serializer => _$movieSerializer;
  factory Movie([void Function(MovieBuilder) updates]) = _$Movie;
}

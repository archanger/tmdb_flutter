import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movies_result.dart';

part 'serializers.g.dart';

@SerializersFor([
  Movie,
  MoviesResult,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

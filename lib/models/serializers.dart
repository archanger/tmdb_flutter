import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:movies/helpers/TMDB_date_time_serializer.dart';
import 'package:movies/models/configuration.dart';
import 'package:movies/models/image_configuration.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movies_result.dart';

part 'serializers.g.dart';

@SerializersFor([
  Movie,
  MoviesResult,
  Configuration,
  ImageConfiguration,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..add(TMDBDateTimeSerializer()))
    .build();

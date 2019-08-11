import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:movies/models/image_configuration.dart';

part 'configuration.g.dart';

abstract class Configuration implements Built<Configuration, ConfigurationBuilder> {
  static Serializer<Configuration> get serializer => _$configurationSerializer;

  @BuiltValueField(wireName: 'change_keys')
  BuiltList<String> get changeKeys;

  @BuiltValueField(wireName: 'images')
  ImageConfiguration get imageConfiguration;

  Configuration._();
  factory Configuration([void Function(ConfigurationBuilder) updates]) = _$Configuration;
}

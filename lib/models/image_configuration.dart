import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'image_configuration.g.dart';

abstract class ImageConfiguration implements Built<ImageConfiguration, ImageConfigurationBuilder> {
  static Serializer<ImageConfiguration> get serializer => _$imageConfigurationSerializer;

  @BuiltValueField(wireName: 'secure_base_url')
  String get baseUrl;

  @BuiltValueField(wireName: 'backdrop_sizes')
  BuiltList<String> get backdropSizes;

  @BuiltValueField(wireName: 'logo_sizes')
  BuiltList<String> get logoSizes;

  @BuiltValueField(wireName: 'poster_sizes')
  BuiltList<String> get posterSizes;

  @BuiltValueField(wireName: 'profile_sizes')
  BuiltList<String> get profileSizes;

  @BuiltValueField(wireName: 'still_sizes')
  BuiltList<String> get stillSizes;

  ImageConfiguration._();
  factory ImageConfiguration([void Function(ImageConfigurationBuilder) updates]) = _$ImageConfiguration;
}

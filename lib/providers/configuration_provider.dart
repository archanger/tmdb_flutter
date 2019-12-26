import 'package:built_collection/built_collection.dart';
import 'package:movies/models/configuration.dart';
import 'package:movies/models/image_configuration.dart';

class ConfigurationProvider {
  String get apiKey => '27f041b87264c855c1f8d198c9d73cfe';

  update(Configuration configuration) {
    _config.rebuild((b) => b
      ..imageConfiguration = configuration.imageConfiguration.toBuilder()
      ..changeKeys = configuration.changeKeys.toBuilder());
  }

  Configuration _config = Configuration(
    (b) => b
      ..imageConfiguration = ImageConfigurationBuilderAdditions.empty()
      ..changeKeys = ListBuilder([]),
  );

  static final ConfigurationProvider _singleton = ConfigurationProvider._internal();

  factory ConfigurationProvider() {
    return _singleton;
  }

  ConfigurationProvider._internal();
}

import 'package:built_collection/built_collection.dart';
import 'package:movies/models/configuration.dart';
import 'package:movies/models/image_configuration.dart';

final globalConfigProvider = ConfigurationProvider._internal();

class ConfigurationProvider {
  String get apiKey => '27f041b87264c855c1f8d198c9d73cfe';

  update(Configuration configuration) {
    _config = configuration;
  }

  Configuration get configuration => _config;

  Configuration _config = Configuration(
    (b) => b
      ..imageConfiguration = ImageConfigurationBuilderAdditions.empty()
      ..changeKeys = ListBuilder([]),
  );

  String posterBaseUrlFitting(int size) {
    final sizes = _config.imageConfiguration.posterSizes
        .where((ps) => ps != 'original')
        .map((ps) => ps.substring(1))
        .map(int.parse)
        .toList();
    var pixelSize = size * 2;

    final nearestSize = _findNearest(sizes, pixelSize);
    return _config.imageConfiguration.baseUrl + 'w$nearestSize';
  }

  int _findNearest(List<int> list, int value) {
    final Map<int, int> map = {};
    list.asMap().forEach((index, item) {
      map[(value - item).abs()] = index;
    });

    final keys = map.keys.toList();
    keys.sort();
    return list[map[keys.first]];
  }

  ConfigurationProvider._internal();
}

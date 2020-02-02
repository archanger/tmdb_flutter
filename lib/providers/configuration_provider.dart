import 'package:built_collection/built_collection.dart';
import 'package:movies/models/configuration.dart';
import 'package:movies/models/image_configuration.dart';
import 'package:movies/splash/configuration_service.dart';

final globalConfigProvider = ConfigurationProvider._internal();

class ConfigurationProvider {
  update(Configuration configuration) {
    _config = configuration;
  }

  updateSupportedLanguages(List<MoviesLanguage> languages) {
    _supportedLanguages = languages;
    updateCurrentLocale(_locale);
  }

  void updateCurrentLocale(String locale) {
    _locale = locale;
    _currentLanguage = _supportedLanguages.firstWhere(
      (lng) => lng.iso == locale,
      orElse: () => MoviesLanguage('en', 'English', 'English'),
    );
  }

  Configuration get configuration => _config;
  List<MoviesLanguage> get supportedLanguages => _supportedLanguages;
  MoviesLanguage get currentLanguage => _currentLanguage;

  Configuration _config = Configuration(
    (b) => b
      ..imageConfiguration = ImageConfigurationBuilderAdditions.empty()
      ..changeKeys = ListBuilder([]),
  );

  List<MoviesLanguage> _supportedLanguages = [];
  MoviesLanguage _currentLanguage;
  String _locale = 'en';

  String posterBaseUrlFitting(int size) {
    return _config.imageConfiguration.baseUrl + _findImageSize(size, _config.imageConfiguration.posterSizes.asList());
  }

  String backdropUrlFitting(int size) {
    return _config.imageConfiguration.baseUrl + _findImageSize(size, _config.imageConfiguration.backdropSizes.asList());
  }

  String _findImageSize(int size, List<String> imageSizes) {
    final pixelSize = size * 2;
    final sizes = imageSizes.where((ps) => ps != 'original').map((ps) => ps.substring(1)).map(int.parse).toList();
    return 'w${_findNearest(sizes, pixelSize)}';
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

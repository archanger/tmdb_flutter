import 'dart:async';

import 'package:movies/helpers/bloc.dart';
import 'package:movies/providers/configuration_provider.dart';
import 'package:movies/splash/configuration_service.dart';

class SplashBloc implements Bloc {
  final Completer<void> _subject = Completer();
  final ConfigurationService _service;
  final ConfigurationProvider _configProvider;

  SplashBloc(this._service, this._configProvider) {
    _fetchConfig();
  }

  Future<void> get completed => _subject.future;

  setupLocale(String locale) {
    _configProvider.updateCurrentLocale(locale);
  }

  _fetchConfig() async {
    try {
      final config = await _service.fetchImageConfig();
      _configProvider.update(config);
      final languages = await _service.fetchLanguages();
      _configProvider.updateSupportedLanguages(languages);
      _subject.complete();
    } catch (e) {
      _subject.completeError(e);
    }
  }

  @override
  void dispose() {}
}

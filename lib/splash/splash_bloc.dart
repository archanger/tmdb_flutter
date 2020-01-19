import 'dart:async';

import 'package:movies/helpers/bloc.dart';
import 'package:movies/providers/configuration_provider.dart';
import 'package:movies/splash/configuration_service.dart';

class SplashBloc implements Bloc {
  // TODO: move to Future
  final Completer<void> _subject = Completer();
  final ConfigurationService _service;
  final ConfigurationProvider _configProvider;

  SplashBloc(this._service, this._configProvider) {
    _service.fetchConfig().then((v) {
      _configProvider.update(v);
      _subject.complete();
    }).catchError((e) => _subject.completeError(e));
  }
  Future<void> get completed => _subject.future;

  @override
  void dispose() {}
}

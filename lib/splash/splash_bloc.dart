import 'package:movies/providers/configuration_provider.dart';
import 'package:movies/splash/configuration_service.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc {
  final PublishSubject<void> _subject = PublishSubject();
  final ConfigurationService _service;
  final ConfigurationProvider _configProvider;

  SplashBloc(this._service, this._configProvider) {
    _service.fetchConfig().then((v) {
      _configProvider.update(v);
      _subject.add(null);
      _subject.close();
    }).catchError((e) => _subject.addError(e));
  }
  Observable<void> get completed => _subject.stream;
}

import 'package:movies/splash/configuration_service.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc {
  final Observable<void> _stream;
  final ConfigurationService _service;

  SplashBloc(this._service)
      : _stream = Observable.fromFuture(_service.fetchConfig()).map(
          (b) => null,
        );
  Observable<void> get completed => _stream;
}

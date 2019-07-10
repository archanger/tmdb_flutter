import 'package:rxdart/rxdart.dart';

class SplashBloc {
  final Observable<void> _stream = Observable.fromFuture(
    Future.delayed(Duration(seconds: 2)),
  );
  Observable<void> get completed => _stream;
}

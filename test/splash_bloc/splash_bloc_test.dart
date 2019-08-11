import 'package:movies/splash/configuration_service.dart';
import 'package:movies/splash/splash_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('SplashBloc', () {
    test('emits finished loading', () async {
      final subject = SplashBloc(ConfigurationService());
      await expectLater(subject.completed, emitsAnyOf([null, emitsDone]));
    });
  });
}

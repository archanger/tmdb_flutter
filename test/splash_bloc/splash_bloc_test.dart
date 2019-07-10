import 'package:movies/splash/splash_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('SplashBloc', () {
    test('emits finished loading', () async {
      final subject = SplashBloc();
      await expectLater(subject.completed, emitsInOrder([null, emitsDone]));
    });
  });
}

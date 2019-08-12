import 'package:built_collection/built_collection.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/models/configuration.dart';
import 'package:movies/models/image_configuration.dart';
import 'package:movies/splash/splash_bloc.dart';
import 'package:test/test.dart';

import 'mocks.dart';

void main() {
  group('SplashBloc', () {
    test('emits finished loading', () async {
      final mockService = ConfigurationServiceMock();

      when(mockService.fetchConfig()).thenAnswer(
        (v) => Future.value(
          Configuration((b) => b
            ..imageConfiguration = (ImageConfigurationBuilder()
              ..baseUrl = ""
              ..logoSizes = ListBuilder([])
              ..posterSizes = ListBuilder([])
              ..profileSizes = ListBuilder([]))
            ..changeKeys = ListBuilder([])),
        ),
      );

      final subject = SplashBloc(mockService);
      await expectLater(subject.completed, emitsAnyOf([null, emitsDone]));
    });
  });
}

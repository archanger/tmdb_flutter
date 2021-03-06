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
      final configMock = ConfigurationProviderMock();
      final config = Configuration(
        [],
        ImageConfigurationAdditions.empty(),
      );

      when(mockService.fetchImageConfig()).thenAnswer(
        (v) => Future.value(config),
      );

      logInvocations([configMock]);
      final subject = SplashBloc(mockService, configMock);
      await subject.completed;
      verify(configMock.update(config)).called(1);
    });
  });
}

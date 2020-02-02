import 'package:mockito/mockito.dart';
import 'package:movies/models/movie_detail.dart';
import 'package:movies/movie_details/movie_details_bloc.dart';
import 'package:test/test.dart';

import 'mocks.dart';

void main() {
  group('MovieDetailsBloc', () {
    test('return details for a movie', () {
      final configMock = ConfigurationProviderMock();
      when(configMock.backdropUrlFitting(0)).thenReturn('expected');

      final serviceMock = MovieDetailsServiceMock();
      when(serviceMock.fetchDetails(0)).thenAnswer((_) {
        return Future.value(_fakeMovie());
      });

      final subject = MovieDetailsBloc(
        id: 0,
        service: serviceMock,
        config: configMock,
      );

      expect(
        subject.details,
        emitsInOrder([
          _fakeMovie(),
        ]),
      );
    });
  });
}

MovieDetail _fakeMovie() {
  return MovieDetail(
    0,
    'title',
    'storyLine',
    'url',
    ['one', 'two'],
  );
}

import 'package:mockito/mockito.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movies_result.dart';
import 'package:movies/movies_list/movies_list_bloc.dart';
import 'package:movies/movies_list/movies_list_state.dart';
import 'package:test/test.dart';

import 'mocks.dart';

void main() {
  group('MoviesListBloc', () {
    test('returns a list of movies', () {
      final mockService = MoviesServiceMock();
      when(mockService.fetchUpcomingMovies()).thenAnswer((_) => Future.value(_fakeMoviesState()));

      final configProvider = ConfigurationProviderMock();
      when(configProvider.posterBaseUrlFitting(0)).thenReturn('');
      final subject = MoviesListBloc(service: mockService, configProvider: configProvider);

      expect(
          subject.allMovies,
          emitsInOrder([
            MoviesListState.empty(),
            _expectedState(),
          ]));
    });
  });
}

MoviesResult _fakeMoviesState() => MoviesResult(1, 1, 3, [
      Movie(
        1,
        'Закатать в асфальт',
        'poster_path',
        3.4,
        DateTime(2019, 5, 12),
      ),
      Movie(
        2,
        'Удивительный мир Марвена',
        'poster_path',
        2.2,
        DateTime(2019, 2, 2),
      ),
      Movie(
        3,
        'Хеллбой',
        'poster_path',
        8.9,
        DateTime(2019, 8, 22),
      ),
    ]);

MoviesListState _expectedState() => MoviesListState(
      _fakeMoviesState().results,
      false,
    );

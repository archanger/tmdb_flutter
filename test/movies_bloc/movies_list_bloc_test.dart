import 'package:built_collection/built_collection.dart';
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
      final subject = MoviesListBloc(service: mockService);

      expect(subject.allMovies, emitsInOrder([MoviesListState.empty(), _expectedState()]));
    });
  });
}

MoviesResult _fakeMoviesState() => MoviesResult((b) => b
  ..page = 1
  ..totalPages = 1
  ..totalResults = 3
  ..results = ListBuilder([
    Movie((b) => b
      ..id = 1
      ..voteAverage = 3.4
      ..title = 'Закатать в асфальт'
      ..posterPath = 'poster_path'
      ..releaseDate = DateTime(2019, 5, 12)),
    Movie((b) => b
      ..id = 2
      ..voteAverage = 2.2
      ..title = 'Удивительный мир Марвена'
      ..posterPath = 'poster_path'
      ..releaseDate = DateTime(2019, 2, 2)),
    Movie((b) => b
      ..id = 3
      ..title = 'Хеллбой'
      ..voteAverage = 8.9
      ..posterPath = 'poster_path'
      ..releaseDate = DateTime(2019, 8, 22)),
  ]));

MoviesListState _expectedState() => MoviesListState((b) => b
  ..hasAnotherBatch = false
  ..movies = ListBuilder(_fakeMoviesState().results));

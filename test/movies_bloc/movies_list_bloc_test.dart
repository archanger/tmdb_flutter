import 'package:mockito/mockito.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/movies_list/movies_list_bloc.dart';
import 'package:test/test.dart';

import 'mocks.dart';

void main() {
  group('MoviesListBloc', () {
    test('returns a list of movies', () {
      final mockService = MoviesServiceMock();
      when(mockService.fetchUpcomingMovies()).thenAnswer((_) => Future.value(_fakeMovies()));
      final subject = MoviesListBloc(service: mockService);

      expect(subject.allMovies, emitsInOrder([[], _fakeMovies()]));
    });
  });
}

List<Movie> _fakeMovies() => [
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
    ];

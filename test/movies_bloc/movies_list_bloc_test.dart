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
        ..title = 'Закатать в асфальт'
        ..posterPath = 'poster_path'),
      Movie((b) => b
        ..title = 'Удивительный мир Марвена'
        ..posterPath = 'poster_path'),
      Movie((b) => b
        ..title = 'Хеллбой'
        ..posterPath = 'poster_path'),
    ];

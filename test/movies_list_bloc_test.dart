import 'package:movies/models/movie.dart';
import 'package:movies/movies_list/movies_list_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('MoviesListBloc', () {
    test('returns a list of movies', () {
      final subject = MoviesListBloc();

      expect(subject.allMovies, emits(_fakeMovies()));
    });
  });
}

List<Movie> _fakeMovies() => [
      Movie('Закатать в асфальт'),
      Movie('Удивительный мир Марвена'),
      Movie('Хеллбой'),
    ];

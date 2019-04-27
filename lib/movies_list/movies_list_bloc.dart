import 'package:meta/meta.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:movies/models/movie.dart';

class MoviesListBloc {
  final MoviesService _service;
  final _moviesFetcher = BehaviorSubject<List<Movie>>.seeded([]);

  MoviesListBloc({
    @required MoviesService service,
  }) : _service = service {
    fetchMovies();
  }

  Observable<List<Movie>> get allMovies => _moviesFetcher.stream;
  void fetchMovies() {
    _service.fetchUpcomingMovies().then((movies) => _moviesFetcher.sink.add(movies));
  }

  void dispose() {
    _moviesFetcher.close();
  }
}

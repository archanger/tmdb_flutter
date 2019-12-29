import 'package:meta/meta.dart';
import 'package:movies/movies_list/movies_list_state.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  final MoviesService _service;
  final _moviesFetcher = BehaviorSubject<MoviesListState>.seeded(MoviesListState.empty());
  var _currentPage = 0;
  var _currentState = MoviesListState.empty();
  var _isFetching = false;

  MoviesListBloc({
    @required MoviesService service,
  }) : _service = service {
    fetchNextPage();
  }

  Stream<MoviesListState> get allMovies => _moviesFetcher.stream;
  void fetchNextPage() {
    if (_isFetching) return;
    _isFetching = true;

    _currentPage++;
    _service.fetchUpcomingMovies(page: _currentPage).then((result) {
      _currentState = MoviesListState(
        _currentState.movies + result.results,
        result.page < result.totalPages,
      );

      _isFetching = false;
      _moviesFetcher.sink.add(_currentState);
    });
  }

  void dispose() {
    _moviesFetcher.close();
  }
}

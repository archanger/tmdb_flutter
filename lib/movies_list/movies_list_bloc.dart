import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';
import 'package:movies/movies_list/movies_list_state.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  final MoviesService _service;
  final _moviesFetcher = BehaviorSubject<MoviesListState>.seeded(MoviesListState.empty());
  var _currentPage = 0;
  var _currentState = MoviesListState.empty();

  MoviesListBloc({
    @required MoviesService service,
  }) : _service = service {
    fetchNextPage();
  }

  Observable<MoviesListState> get allMovies => _moviesFetcher.stream;
  void fetchNextPage() {
    _currentPage++;
    _service.fetchUpcomingMovies(page: _currentPage).then((result) {
      _currentState = MoviesListState(
        (b) => b
          ..movies = ListBuilder(_currentState.movies + result.results)
          ..hasAnotherBatch = result.page < result.totalPages,
      );

      _moviesFetcher.sink.add(_currentState);
    });
  }

  void dispose() {
    _moviesFetcher.close();
  }
}

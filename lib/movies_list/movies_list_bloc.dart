import 'package:meta/meta.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/movies_list/movies_list_state.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:movies/providers/configuration_provider.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  final MoviesService _service;
  final ConfigurationProvider _configProvider;
  final _moviesFetcher = BehaviorSubject<MoviesListState>.seeded(MoviesListState.empty());
  var _currentPage = 0;
  var _currentState = MoviesListState.empty();
  var _isFetching = false;
  var _adjustedPosterSize = 0;

  MoviesListBloc({
    @required MoviesService service,
    @required ConfigurationProvider configProvider,
  })  : _service = service,
        _configProvider = configProvider {
    fetchNextPage();
  }

  Stream<MoviesListState> get allMovies => _moviesFetcher.stream;

  void fetchNextPage() async {
    if (_isFetching) return;
    _isFetching = true;

    _currentPage++;
    final result = await _service.fetchUpcomingMovies(page: _currentPage);
    _currentState = MoviesListState(
      _currentState.movies +
          result.results
              .map((m) => Movie(
                    m.id,
                    m.title,
                    m.posterPath != null ? _posterUrl() + m.posterPath : null,
                    m.voteAverage,
                    m.releaseDate,
                  ))
              .toList(),
      result.page < result.totalPages,
    );

    _isFetching = false;
    _moviesFetcher.sink.add(_currentState);
  }

  void dispose() {
    _moviesFetcher.close();
  }

  String _posterUrl() => _configProvider.posterBaseUrlFitting(_adjustedPosterSize);

  void adjustTo({int size}) => _adjustedPosterSize = size;
}

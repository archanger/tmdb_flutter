import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movies/helpers/bloc.dart';
import 'package:movies/models/movie_detail.dart';
import 'package:movies/movies_list/movies_service.dart';
import 'package:movies/providers/configuration_provider.dart';

class MovieDetailsBloc implements Bloc {
  final MoviesService _service;
  final ConfigurationProvider _configProvider;
  var _adjustedPosterSize = 0;

  final _fetcher = StreamController<MovieDetail>();

  MovieDetailsBloc({
    @required int id,
    @required MoviesService service,
    @required ConfigurationProvider config,
  })  : _service = service,
        _configProvider = config {
    _fetch(id);
  }

  Stream<MovieDetail> get details => _fetcher.stream;

  void adjustTo({int size}) => _adjustedPosterSize = size;

  _fetch(int id) async {
    var details = await _service.fetchDetails(id);
    _fetcher.sink.add(MovieDetail(
      details.id,
      details.title,
      details.storyLine,
      _posterUrl() + details.backdrop,
      details.genres,
    ));
  }

  String _posterUrl() => _configProvider.posterBaseUrlFitting(_adjustedPosterSize);

  @override
  void dispose() {
    _fetcher.close();
  }
}

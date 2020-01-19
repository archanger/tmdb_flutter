import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movies/helpers/bloc.dart';
import 'package:movies/models/movie_detail.dart';
import 'package:movies/movies_list/movies_service.dart';

class MovieDetailsBloc implements Bloc {
  final MoviesService _service;

  final _fetcher = StreamController<MovieDetail>();

  MovieDetailsBloc({
    @required int id,
    @required MoviesService service,
  }) : _service = service {
    _fetch(id);
  }

  Stream<MovieDetail> get details => _fetcher.stream;

  _fetch(int id) async {
    var details = await _service.fetchDetails(id);
    _fetcher.sink.add(details);
  }

  @override
  void dispose() {
    _fetcher.close();
  }
}

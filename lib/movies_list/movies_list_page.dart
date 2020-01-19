import 'package:flutter/material.dart';
import 'package:movies/helpers/bloc_provider.dart';
import 'package:movies/movies_list/movie_list_item.dart';
import 'package:movies/movies_list/movies_list_bloc.dart';
import 'package:movies/movies_list/movies_list_state.dart';
import 'package:movies/providers/configuration_provider.dart';

import 'movies_service.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    bloc.adjustTo(size: 92);
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Movies'),
      ),
      body: Center(
        child: StreamBuilder<MoviesListState>(
          stream: bloc.allMovies,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data.movies.isEmpty) {
              return _loading();
            }

            final data = snapshot.data;

            return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                key: Key('movies_list'),
                controller: _scrollController,
                itemCount: _itemsCount(data),
                itemBuilder: (_, index) => _listItem(data, index),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  int _itemsCount(MoviesListState state) => state.movies.length + (state.hasAnotherBatch ? 1 : 0);

  Widget _listItem(MoviesListState state, int index) {
    if (index >= state.movies.length) {
      return _loading();
    }

    var movieId = state.movies[index].id;
    return GestureDetector(
      child: Padding(
        key: Key('$movieId'),
        padding: EdgeInsets.only(top: index == 0 ? 20 : 0),
        child: MovieListItem(movie: state.movies[index]),
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/details', arguments: movieId);
      },
    );
  }

  MoviesListBloc get bloc => BlocProvider.of<MoviesListBloc>(context);

  bool _handleScrollNotification(ScrollNotification notification) {
    final triggerSize = _scrollController.position.maxScrollExtent * 0.9;
    if (notification is ScrollEndNotification && _scrollController.position.pixels > triggerSize) {
      bloc.fetchNextPage();
    }

    return false;
  }
}

class MoviesListFactory {
  Widget listPage() {
    return BlocProvider(
      bloc: MoviesListBloc(
        service: MoviesService(),
        configProvider: globalConfigProvider,
      ),
      child: MoviesListPage(),
    );
  }
}

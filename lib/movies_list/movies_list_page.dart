import 'package:flutter/material.dart';
import 'package:movies/movies_list/movie_list_item.dart';
import 'package:movies/movies_list/movies_list_bloc.dart';
import 'package:movies/movies_list/movies_list_state.dart';

class MoviesListPage extends StatefulWidget {
  final MoviesListBloc _bloc;

  const MoviesListPage({
    Key key,
    @required MoviesListBloc bloc,
  })  : _bloc = bloc,
        super(key: key);

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
    bloc.dispose();
    super.dispose();
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  int _itemsCount(MoviesListState state) => state.movies.length + (state.hasAnotherBatch ? 1 : 0);

  Widget _listItem(MoviesListState state, int index) {
    var movieId = state.movies[index].id;
    return index >= state.movies.length
        ? _loading()
        : GestureDetector(
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

  MoviesListBloc get bloc => widget._bloc;

  bool _handleScrollNotification(ScrollNotification notification) {
    final triggerSize = _scrollController.position.maxScrollExtent * 0.9;
    if (notification is ScrollEndNotification && _scrollController.position.pixels > triggerSize) {
      bloc.fetchNextPage();
    }

    return false;
  }
}

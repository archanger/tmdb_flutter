import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/movies_list/movie_list_item_widget.dart';
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
  @override
  Widget build(BuildContext context) {
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

            return ListView.builder(
              key: Key('movies_list'),
              itemCount: _itemsCount(data),
              itemBuilder: (_, index) => _listItem(data, index),
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
    return index >= state.movies.length
        ? _loading()
        : Padding(
            padding: EdgeInsets.only(top: index == 0 ? 20 : 0),
            child: MovieListItem(movie: state.movies[index]),
          );
  }

  MoviesListBloc get bloc => widget._bloc;
}

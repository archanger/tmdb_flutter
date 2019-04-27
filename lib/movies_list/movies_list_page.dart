import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/movies_list/movies_list_bloc.dart';

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
        child: StreamBuilder<List<Movie>>(
            stream: bloc.allMovies,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              final data = snapshot.data;

              return ListView.builder(
                key: Key('movies_list'),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].title),
                  );
                },
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  MoviesListBloc get bloc => widget._bloc;
}

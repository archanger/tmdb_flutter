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
                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 20 : 0),
                    child: MovieListItem(movie: data[index]),
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

class MovieListItem extends StatelessWidget {
  final Movie _movie;

  const MovieListItem({
    Key key,
    @required Movie movie,
  })  : _movie = movie,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            padding: EdgeInsets.only(left: 90),
            child: Row(
              children: <Widget>[
                Expanded(child: _MovieListItemContent(movie: _movie)),
              ],
            ),
          ),
          _MovieItemPoster(url: 'https://image.tmdb.org/t/p/w185${_movie.posterPath}'),
        ],
      ),
    );
  }
}

class _MovieListItemContent extends StatelessWidget {
  const _MovieListItemContent({
    Key key,
    @required Movie movie,
  })  : _movie = movie,
        super(key: key);

  final Movie _movie;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF1D292E),
          border: Border.all(color: Color(0xa0ffffff)),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _movie.title,
              style: Theme.of(context).textTheme.headline,
            ),
            SizedBox(height: 8),
            Text(
              'raiting: ${_movie.voteAverage}',
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 8),
            Text(
              'Release: ${DateTimeFormatters.tmdbDateFrom(_movie.releaseDate)}',
              style: Theme.of(context).textTheme.subhead,
            )
          ],
        ),
      ),
    );
  }
}

class _MovieItemPoster extends StatelessWidget {
  final String _url;

  const _MovieItemPoster({Key key, @required String url})
      : _url = url,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        width: 92,
        height: 92 / 0.6,
        child: Image.network(
          _url,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class DateTimeFormatters {
  static String tmdbDateFrom(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  DateTimeFormatters._();
}

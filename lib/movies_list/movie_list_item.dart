import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/movies_list/movie_item_poster.dart';
import 'package:movies/movies_list/movie_list_item_content.dart';

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
                Expanded(child: MovieListItemContent(movie: _movie)),
              ],
            ),
          ),
          MovieItemPoster(posterPath: _movie.posterPath),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/tools/date_time_formatters.dart';

class MovieListItemContent extends StatelessWidget {
  const MovieListItemContent({
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
          border: Border.all(color: Color(0x0affffff)),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _movie.title,
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 8),
            Text(
              'raiting: ${_movie.voteAverage}',
              style: Theme.of(context).textTheme.body2,
            ),
            SizedBox(height: 8),
            Text(
              'Release: ${DateTimeFormatters.tmdbDateFrom(_movie.releaseDate)}',
              style: Theme.of(context).textTheme.body2,
            )
          ],
        ),
      ),
    );
  }
}

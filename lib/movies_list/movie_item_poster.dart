import 'package:flutter/material.dart';

class MovieItemPoster extends StatelessWidget {
  final String _url;

  const MovieItemPoster({Key key, @required String posterPath})
      : _url = posterPath,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        width: 92,
        height: 92 / 0.6,
        child: _image(),
      ),
    );
  }

  Widget _image() {
    if (_url == null) {
      return Placeholder();
    }

    return Image.network(
      'https://image.tmdb.org/t/p/w185$_url',
      fit: BoxFit.fill,
    );
  }
}

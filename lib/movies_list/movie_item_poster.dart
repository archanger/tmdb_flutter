import 'package:flutter/material.dart';

class MovieItemPoster extends StatelessWidget {
  final String _url;

  const MovieItemPoster({Key key, @required String url})
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

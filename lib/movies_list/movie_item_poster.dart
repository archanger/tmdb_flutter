import 'package:flutter/material.dart';
import 'package:movies/providers/configuration_provider.dart';

class MovieItemPoster extends StatelessWidget {
  final String _url;
  final _config = ConfigurationProvider();

  MovieItemPoster({Key key, @required String posterPath})
      : _url = posterPath,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
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
      '${_config.configuration.imageConfiguration.baseUrl}w185$_url',
      fit: BoxFit.fill,
    );
  }
}

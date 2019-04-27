final constants = _Constants();

class _Constants {
  final String _movieURL = 'https://api.themoviedb.org/3';
  String nonBaseURL;

  void changeBaseURL(String newURL) {
    nonBaseURL = newURL;
  }

  String get baseURL => nonBaseURL ?? _movieURL;
}

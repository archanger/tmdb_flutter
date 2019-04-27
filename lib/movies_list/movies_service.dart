import 'package:movies/models/movie.dart';

class MoviesService {
  Future<List<Movie>> fetchUpcomingMovies() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value([
      Movie('Закатать в асфальт'),
      Movie('Удивительный мир Марвена'),
      Movie('Хеллбой'),
    ]);
  }
}

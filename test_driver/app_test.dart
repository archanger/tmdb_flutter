import 'package:test/test.dart';

import '../application/application.dart';
import '../web_server/web_server.dart';

void main() {
  group("movie", () {
    Application application = Application();
    FakeServer server = FakeServer();

    setUpAll(() async {
      await application.start();
      server.start();
    });

    tearDownAll(() async {
      application.stop();
      server.stop();
    });

    test('has a list of movies', () async {
      await application.hasAListOfMovies();
    });
  });
}

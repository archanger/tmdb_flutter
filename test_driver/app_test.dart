import 'package:test/test.dart';

import '../web_server/web_server.dart';
import 'application/application.dart';

void main() {
  group("movie", () {
    Application application = Application();
    FakeServer server = FakeServer();

    setUpAll(() async {
      server.start();
      await application.start();
    });

    tearDownAll(() async {
      server.stop();
      application.stop();
    });

    test('has a list of movies', () async {
      (await application.mainPage().openHome()).checkItems();
    });
  });
}

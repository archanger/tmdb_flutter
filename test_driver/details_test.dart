import 'package:test/test.dart';

import 'application/application.dart';
import '../web_server/web_server.dart';

void main() {
  group("movie details", () {
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

    test('movie with id 530915 has details', () async {
      await (await (await application.mainPage().openHome()).openDetails()).checkContent();
    });
  });
}

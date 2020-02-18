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
      await application.stop();
    });

    test('movie with id 530915 has details', () async {
      final main = application.mainPage();
      final home = await main.openHome();
      final details = await home.openDetails();
      await details.checkContent();
    });
  });
}

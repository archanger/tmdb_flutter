import 'package:flutter_driver/flutter_driver.dart';

class Application {
  FlutterDriver _driver;

  Future<void> start() async {
    _driver = await FlutterDriver.connect();
  }

  Future<void> stop() async {
    _driver?.close();
  }

  Future<void> hasAListOfMovies() async {
    var splash = find.byValueKey('splash_page');
    await _driver.waitFor(splash);

    var firstItem = find.text('Закатать в асфальт');
    var secondItem = find.text('Удивительный мир Марвена');
    var thirdItem = find.text('Хеллбой');
    var fourthItem = find.text('Нежная рука закона');
    var fifthItem = find.text('Люби их всех');

    await _driver.waitFor(firstItem);
    await _driver.waitFor(secondItem);
    await _driver.waitFor(thirdItem);

    var listView = find.byValueKey('movies_list');
    await _driver.scrollUntilVisible(listView, fourthItem, dyScroll: -300);
    await _driver.scrollUntilVisible(listView, fifthItem, dyScroll: -500);
  }
}

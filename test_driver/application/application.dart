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
    var firstItem = find.text('Закатать в асфальт');
    var secondItem = find.text('Удивительный мир Марвена');
    var thirdItem = find.text('Хеллбой');
    var fourthItem = find.text('Нежная рука закона');
    var listView = find.byValueKey('movies_list');
    await _driver.waitFor(firstItem);
    await _driver.waitFor(secondItem);
    await _driver.waitFor(thirdItem);
    // await _driver.scroll(fourthItem, 0, 1000, Duration(seconds: 5));

    await _driver.scrollUntilVisible(listView, fourthItem, dyScroll: -300);
  }
}

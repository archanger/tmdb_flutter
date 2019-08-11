import 'package:flutter_driver/flutter_driver.dart';

import 'base_page.dart';

class HomeScreen extends BasePage {
  final _listView = find.byValueKey('movies_list');
  final _items = [
    find.text('Закатать в асфальт'),
    find.text('Удивительный мир Марвена'),
    find.text('Хеллбой'),
  ];
  final _scrollableItems = [
    find.text('Нежная рука закона'),
    find.text('Люби их всех'),
  ];

  HomeScreen(FlutterDriver driver) : super(driver);

  Future<void> checkItems() async {
    for (var item in _items) {
      await driver.waitFor(item);
    }
    for (var item in _scrollableItems) {
      await driver.scrollUntilVisible(_listView, item, dyScroll: -300);
    }
  }
}

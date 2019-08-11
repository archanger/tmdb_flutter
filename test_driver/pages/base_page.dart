import 'package:flutter_driver/flutter_driver.dart';

class BasePage {
  final FlutterDriver _driver;
  FlutterDriver get driver => _driver;

  BasePage(this._driver);
}

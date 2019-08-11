import 'package:flutter_driver/flutter_driver.dart';

import '../pages/splash_screen.dart';

class Application {
  FlutterDriver _driver;

  Future<void> start() async {
    _driver = await FlutterDriver.connect();
  }

  Future<void> stop() async {
    _driver?.close();
  }

  SplashScreen mainPage() {
    return SplashScreen(_driver);
  }
}

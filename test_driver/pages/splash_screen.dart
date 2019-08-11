import 'package:flutter_driver/flutter_driver.dart';
import 'base_page.dart';
import 'home_page.dart';

class SplashScreen extends BasePage {
  final _content = find.byValueKey('splash_page');

  SplashScreen(FlutterDriver driver) : super(driver);

  Future<HomeScreen> openHome() async {
    await driver.waitFor(_content);
    return HomeScreen(driver);
  }
}

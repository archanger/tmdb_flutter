import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'base_page.dart';

class DetailsPage extends BasePage {
  final _title = find.byValueKey('title');
  final _storyline = find.byValueKey('story_line');
  final _posterSmall = find.byValueKey('poster_small');

  DetailsPage(FlutterDriver driver) : super(driver);

  checkContent() async {
    await driver.waitFor(_posterSmall);
    expect(await driver.getText(_title), '1917');
    expect(await driver.getText(_storyline), contains('разгар Первой мировой войны'));
  }
}

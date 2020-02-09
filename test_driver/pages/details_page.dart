import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'base_page.dart';

class DetailsPage extends BasePage {
  final _title = find.byValueKey('title');
  final _storyline = find.byValueKey('story_line');
  final _backdrop = find.byValueKey('backdrop');
  final _runtime = find.byValueKey('runtime');
  final _genres = ['военный', 'драма', 'история'];

  DetailsPage(FlutterDriver driver) : super(driver);

  checkContent() async {
    await driver.waitFor(_backdrop);
    _genres.forEach((g) async {
      await driver.waitFor(find.text(g));
    });
    expect(await driver.getText(_runtime), 'Run Time: 1 h 59 min');
    expect(await driver.getText(_title), '1917');
    expect(await driver.getText(_storyline), contains('разгар Первой мировой войны'));
  }
}

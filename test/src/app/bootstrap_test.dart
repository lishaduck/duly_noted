import 'package:duly_noted/src/app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/mocks.dart';

Future<SharedPreferences> getSharedPreferences() async {
  return MockSharedPreferences();
}

void main() {
  setUpAll(() {
    registerFallbackValue(Container());
  });

  test('main does not throw', () async {
    final mockRunApp = MockRunApp();
    const app = MyApp();

    await expectLater(
      app.bootstrap(
        mockRunApp,
        getSharedPreferences,
      ),
      completes,
    );

    // Verify that runApp was called with an instance of MyApp.
    verify(() => mockRunApp.runApp(app, overrides: any(named: 'overrides')))
        .called(1);
  });
}

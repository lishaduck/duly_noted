import 'package:shared_preferences/shared_preferences.dart';

import 'src/app/app.dart';
import 'src/app/bootstrap.dart';

Future<void> main() async {
  await const MyApp().bootstrap(
    const RunApp(),
    SharedPreferences.getInstance,
  );
}

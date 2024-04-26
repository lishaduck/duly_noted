import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
import 'src/app/bootstrap.dart' as app;

Future<void> main() async {
  await const MyApp().bootstrap(
    const app.RunApp(),
    SharedPreferences.getInstance,
  );
}

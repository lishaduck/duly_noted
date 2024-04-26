import 'dart:developer';

import 'package:flutter/material.dart' as flutter show runApp;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/settings/initial_settings.dart';
import '../utils/settings/preferences.dart';
import '../utils/settings/settings_controller.dart';

/// Turn any widget into a flow-blown app.
mixin Bootstrap on Widget {
  /// Bootstrap the app.
  ///
  /// This involves
  /// - setting [FlutterError.onError] to log errors to the console,
  /// - calling [usePathUrlStrategy] to use path-style URLs,
  /// - setting up the [SettingsController] and loading the user's preferences,
  /// - initializing riverpod's [ProviderScope], and
  /// - running the app with [RunApp].
  Future<void> bootstrap(
    RunApp runApp,
    Future<SharedPreferences> Function() getSharedPreferences,
  ) async {
    FlutterError.onError = (details) =>
        log(details.exceptionAsString(), stackTrace: details.stack);

    // Don't use hash style routes.
    usePathUrlStrategy();

    // Reset notification bar on Android.
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );

    // Load the user's preferences.
    final prefs = await getSharedPreferences();
    final initialSettings = await loadSettings(prefs);

    // Run the app and pass in the SettingsController. The app listens to the
    // SettingsController for changes, then passes it further down to the
    // SettingsView.
    runApp.runApp(
      this,
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        initialSettingsProvider.overrideWithValue(initialSettings),
      ],
    );
  }
}

/// {@template RunApp}
/// Allow mocking runApp in tests.
/// {@endtemplate}
class RunApp {
  /// {@macro RunApp}
  const RunApp();

  /// See [flutter.runApp]
  void runApp(
    Widget app, {
    List<Override> overrides = const [],
  }) {
    flutter.runApp(
      ProviderScope(
        overrides: overrides,
        child: app,
      ),
    );
  }
}

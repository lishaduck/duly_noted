import 'package:flutter/material.dart' as flutter show runApp;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/settings/preferences.dart';
import '../utils/settings/settings_controller.dart';

/// Turn any widget into a flow-blown app.
mixin Bootstrap on Widget {
  /// Bootstrap the app.
  ///
  /// This involves
  /// - setting up the [SettingsController] and loading the user's preferences,
  /// - initializing riverpod's [ProviderScope],
  /// - running the app with [RunApp].
  Future<void> bootstrap(
    RunApp runApp,
    Future<SharedPreferences> Function() getSharedPreferences,
  ) async {
    final prefs = await getSharedPreferences();

    // Run the app and pass in the SettingsController. The app listens to the
    // SettingsController for changes, then passes it further down to the
    // SettingsView.
    runApp.runApp(
      this,
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
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

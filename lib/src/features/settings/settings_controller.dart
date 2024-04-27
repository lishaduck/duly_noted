import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'initial_settings.dart';
import 'preferences.dart';
import 'settings_model.dart';

part 'settings_controller.g.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  SettingsModel build() {
    return ref.watch(initialSettingsProvider);
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateSettings(SettingsModel? settingsModel) async {
    if (settingsModel == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (settingsModel == state) return;

    // Otherwise, store the new ThemeMode in memory
    state = settingsModel;

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await ref
        .read(sharedPreferencesProvider)
        .setString('prefs', json.encode(state));
  }
}

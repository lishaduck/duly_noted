import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_model.dart';

part 'initial_settings.g.dart';

/// Load the user's settings from a local database or the internet.
Future<SettingsModel> loadSettings(SharedPreferences prefs) async {
  final data = prefs.getString('prefs');
  if (data != null) {
    final Object? decoded = json.decode(data);
    if (decoded is Map<String, dynamic>) {
      return SettingsModel.fromJson(decoded);
    }
  }

  return const SettingsModel(themeMode: ThemeMode.system);
}

@Riverpod(keepAlive: true)
SettingsModel initialSettings(InitialSettingsRef ref) {
  throw UnimplementedError();
}

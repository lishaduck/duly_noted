import 'package:duly_noted/src/features/settings/application/settings_service.dart';
import 'package:duly_noted/src/features/settings/data/preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  group('SettingsService', () {
    test('should update the theme mode', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(mockSharedPreferences),
          initialSettingsProvider.overrideWithValue(defaultSettings),
        ],
      );

      final model = container.read(settingsServiceProvider);
      final notifier = container.read(settingsServiceProvider.notifier);

      expect(model.themeMode, ThemeMode.system);

      await notifier.updateThemeMode(ThemeMode.light);

      final newModel = container.read(settingsServiceProvider);
      expect(newModel.themeMode, ThemeMode.light);
    });
  });

  group('initialPreferences', () {
    test('should throw an error if initialPreferences is not provided', () {
      // Arrange
      final container = ProviderContainer();

      // Act
      PreferencesRepository call() =>
          container.read(preferencesRepositoryProvider);

      // Assert
      expect(call, throwsA(isA<UnimplementedError>()));
    });
  });
}

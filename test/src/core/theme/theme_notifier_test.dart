import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';

void main() {
  late MockSharedPreferencesService service;

  setUp(() {
    service = MockSharedPreferencesService();
    when(() => service.setString(any(), any())).thenAnswer((_) async => true);
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(service),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('ThemeNotifier', () {
    group('build', () {
      test('defaults to dark when nothing saved', () {
        when(() => service.getString(SharedPreferencesKeys.themeKey))
            .thenReturn('');

        final container = makeContainer();

        expect(container.read(themeNotifierProvider), ThemeMode.dark);
      });

      test('returns light when light is saved', () {
        when(() => service.getString(SharedPreferencesKeys.themeKey))
            .thenReturn(ThemeMode.light.name);

        final container = makeContainer();

        expect(container.read(themeNotifierProvider), ThemeMode.light);
      });
    });

    group('toggleTheme', () {
      test('flips dark to light and persists the choice', () async {
        when(() => service.getString(SharedPreferencesKeys.themeKey))
            .thenReturn('');

        final container = makeContainer();
        await container.read(themeNotifierProvider.notifier).toggleTheme();

        expect(container.read(themeNotifierProvider), ThemeMode.light);
        verify(
          () => service.setString(
            SharedPreferencesKeys.themeKey,
            ThemeMode.light.name,
          ),
        ).called(1);
      });

      test('flips light back to dark', () async {
        when(() => service.getString(SharedPreferencesKeys.themeKey))
            .thenReturn(ThemeMode.light.name);

        final container = makeContainer();
        final notifier = container.read(themeNotifierProvider.notifier);
        await notifier.toggleTheme();

        expect(container.read(themeNotifierProvider), ThemeMode.dark);
      });

      test('isDarkMode reflects the current state', () {
        when(() => service.getString(SharedPreferencesKeys.themeKey))
            .thenReturn('');

        final container = makeContainer();

        expect(
          container.read(themeNotifierProvider.notifier).isDarkMode,
          isTrue,
        );
      });
    });
  });
}

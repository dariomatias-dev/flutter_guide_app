import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/shared/widgets/change_theme_button_widget.dart';
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

  Widget wrap() => ProviderScope(
        overrides: [
          sharedPreferencesServiceProvider.overrideWithValue(service),
        ],
        child: const MaterialApp(
          home: Scaffold(body: ChangeThemeButtonWidget()),
        ),
      );

  group('ChangeThemeButtonWidget', () {
    testWidgets('shows the light-mode icon while in dark theme',
        (tester) async {
      when(() => service.getString(SharedPreferencesKeys.themeKey))
          .thenReturn('');

      await tester.pumpWidget(wrap());

      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    });

    testWidgets('persists the toggled theme when tapped', (tester) async {
      when(() => service.getString(SharedPreferencesKeys.themeKey))
          .thenReturn('');

      await tester.pumpWidget(wrap());
      await tester.tap(find.byIcon(Icons.light_mode_outlined));
      await tester.pump();

      verify(
        () => service.setString(SharedPreferencesKeys.themeKey, 'light'),
      ).called(1);
    });
  });
}

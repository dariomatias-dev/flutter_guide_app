import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/shared/widgets/back_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';

void main() {
  late MockSharedPreferencesService service;

  setUp(() {
    service = MockSharedPreferencesService();
    when(() => service.getString(SharedPreferencesKeys.themeKey))
        .thenReturn('');
    when(() => service.setString(any(), any())).thenAnswer((_) async => true);
  });

  Widget wrap(StandardAppBarWidget appBar) => ProviderScope(
        overrides: [
          sharedPreferencesServiceProvider.overrideWithValue(service),
        ],
        child: MaterialApp(home: Scaffold(appBar: appBar)),
      );

  group('StandardAppBarWidget', () {
    testWidgets('renders the title from titleName', (tester) async {
      await tester.pumpWidget(
        wrap(const StandardAppBarWidget(titleName: 'Settings')),
      );

      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('shows the back button by default', (tester) async {
      await tester.pumpWidget(
        wrap(const StandardAppBarWidget(titleName: 'Settings')),
      );

      expect(find.byType(BackButtonWidget), findsOneWidget);
    });

    testWidgets('hides the back button when showBackButton is false',
        (tester) async {
      await tester.pumpWidget(
        wrap(
          const StandardAppBarWidget(
            titleName: 'Settings',
            showBackButton: false,
          ),
        ),
      );

      expect(find.byType(BackButtonWidget), findsNothing);
    });

    test('asserts when both titleName and title are provided', () {
      expect(
        () => StandardAppBarWidget(
          titleName: 'Settings',
          title: const Text('Settings'),
        ),
        throwsAssertionError,
      );
    });
  });
}

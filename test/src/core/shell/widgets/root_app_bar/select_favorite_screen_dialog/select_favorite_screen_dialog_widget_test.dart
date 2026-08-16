import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/shell/root_navigation.dart';
import 'package:flutter_guide/src/core/shell/widgets/root_app_bar/root_app_bar_widget.dart';
import 'package:flutter_guide/src/core/shell/widgets/root_app_bar/select_favorite_screen_dialog/select_favorite_screen_dialog_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/saved_components/saved_components_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../helpers/pump_router_app.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    prefs = await createMockPrefs();
  });

  tearDown(resetRouterLocation);

  /// Pumps the shell and opens the favorites dialog from the app bar.
  Future<AppLocalizations> openDialog(WidgetTester tester) async {
    await tester.pumpRouterApp(prefs: prefs);

    final l10n = AppLocalizations.of(
      tester.element(find.byType(RootNavigation)),
    )!;

    // Saved-component cards use the same icon, so scope to the app bar.
    await tester.tap(
      find.descendant(
        of: find.byType(RootAppBarWidget),
        matching: find.byIcon(Icons.bookmark_border),
      ),
    );
    await tester.pumpAndSettle();

    return l10n;
  }

  /// Finds [text] inside the dialog only.
  ///
  /// Tab labels behind the dialog reuse some of these strings, so an
  /// unscoped text finder matches more than one widget.
  Finder inDialog(String text) {
    return find.descendant(
      of: find.byType(SelectFavoriteScreenDialogWidget),
      matching: find.text(text),
    );
  }

  group('SelectFavoriteScreenDialogWidget', () {
    testWidgets('opens from the root app bar bookmark action', (tester) async {
      final l10n = await openDialog(tester);

      expect(find.byType(SelectFavoriteScreenDialogWidget), findsOneWidget);
      expect(find.text(l10n.favorites), findsWidgets);
    });

    testWidgets('lists the three saved component categories', (tester) async {
      final l10n = await openDialog(tester);

      expect(inDialog(l10n.widgets), findsOneWidget);
      expect(inDialog(l10n.functions), findsOneWidget);
      expect(inDialog(l10n.packages), findsOneWidget);
    });

    testWidgets('closes without navigating when Ok is tapped', (tester) async {
      final l10n = await openDialog(tester);

      await tester.tap(inDialog(l10n.ok));
      await tester.pumpAndSettle();

      expect(find.byType(SelectFavoriteScreenDialogWidget), findsNothing);
      expect(find.byType(SavedComponentsScreen), findsNothing);
      expect(find.byType(RootNavigation), findsOneWidget);
    });

    for (final entry in <String, ComponentType>{
      'widgets': ComponentType.widget,
      'functions': ComponentType.function,
      'packages': ComponentType.package,
    }.entries) {
      testWidgets('opens the saved ${entry.key} screen', (tester) async {
        final l10n = await openDialog(tester);

        final label = switch (entry.value) {
          ComponentType.widget => l10n.widgets,
          ComponentType.function => l10n.functions,
          _ => l10n.packages,
        };

        await tester.tap(inDialog(label));
        await tester.pumpAndSettle();

        final screen = tester.widget<SavedComponentsScreen>(
          find.byType(SavedComponentsScreen),
        );

        expect(screen.componentType, entry.value);
        // The dialog pops before pushing, so it must not sit under the
        // screen it opened.
        expect(find.byType(SelectFavoriteScreenDialogWidget), findsNothing);
      });
    }
  });
}

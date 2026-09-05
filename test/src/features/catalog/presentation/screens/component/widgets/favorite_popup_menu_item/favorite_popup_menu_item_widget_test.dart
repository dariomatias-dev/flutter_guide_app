import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/widgets/favorite_popup_menu_item/favorite_popup_menu_item_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../../helpers/mocks.dart';
import '../../../../../../../../helpers/pump_app.dart';

void main() {
  late MockFavoritesRepository repository;

  setUpAll(() {
    registerFallbackValue(ComponentType.widget);
  });

  setUp(() {
    repository = MockFavoritesRepository();
    when(() => repository.getSavedComponentNames(any())).thenReturn([]);
  });

  // A PopupMenuItem asserts it is mounted inside an open menu route, so the
  // widget is exercised the way the app actually shows it: behind a real
  // PopupMenuButton, opened by tapping it. The menu route attaches to the
  // app root Overlay, above anything nested only inside the Scaffold body,
  // so the ProviderScope has to wrap the whole app rather than sit below it.
  Widget menuButton() => PopupMenuButton<void>(
    itemBuilder: (context) => const [
      FavoritePopupMenuItemWidget(
        componentType: ComponentType.widget,
        componentName: 'Container',
      ),
    ],
  );

  Future<void> openMenu(WidgetTester tester) async {
    await tester.pumpScopedApp(
      (app) => ProviderScope(
        overrides: [favoritesRepositoryProvider.overrideWithValue(repository)],
        child: app,
      ),
      menuButton(),
    );
    await tester.tap(find.byType(PopupMenuButton<void>));
    await tester.pumpAndSettle();
  }

  group('FavoritePopupMenuItemWidget', () {
    test('reports a fixed height and never represents a value', () {
      const item = FavoritePopupMenuItemWidget(
        componentType: ComponentType.widget,
        componentName: 'Container',
      );

      expect(item.height, kMinInteractiveDimension);
      expect(item.represents(null), isFalse);
      expect(item.represents('anything'), isFalse);
    });

    testWidgets('shows Save when the component is not saved', (
      tester,
    ) async {
      when(() => repository.getSavedComponentNames(any())).thenReturn([]);

      await openMenu(tester);

      final l10n = AppLocalizations.of(
        tester.element(find.byType(FavoritePopupMenuItemWidget)),
      );

      expect(find.text(l10n.save), findsOneWidget);
    });

    testWidgets('shows Remove when the component is already saved', (
      tester,
    ) async {
      when(
        () => repository.getSavedComponentNames(ComponentType.widget),
      ).thenReturn(['Container']);

      await openMenu(tester);

      final l10n = AppLocalizations.of(
        tester.element(find.byType(FavoritePopupMenuItemWidget)),
      );

      expect(find.text(l10n.remove), findsOneWidget);
    });

    testWidgets('toggles the favorite on tap', (tester) async {
      when(() => repository.getSavedComponentNames(any())).thenReturn([]);
      when(
        () => repository.toggleFavorite(
          type: ComponentType.widget,
          name: 'Container',
        ),
      ).thenReturn(true);

      await openMenu(tester);

      await tester.tap(find.byType(PopupMenuItem<void>));
      await tester.pump();

      verify(
        () => repository.toggleFavorite(
          type: ComponentType.widget,
          name: 'Container',
        ),
      ).called(1);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/save_button/save_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/mocks.dart';
import '../../../../../helpers/pump_app.dart';

void main() {
  late MockFavoritesRepository repository;

  setUpAll(() {
    registerFallbackValue(ComponentType.widget);
  });

  setUp(() {
    repository = MockFavoritesRepository();
    when(() => repository.getSavedComponentNames(any())).thenReturn([]);
  });

  Widget scope({
    ComponentType componentType = ComponentType.widget,
    String componentName = 'Container',
  }) =>
      ProviderScope(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(repository),
        ],
        child: SaveButtonWidget(
          componentType: componentType,
          componentName: componentName,
        ),
      );

  /// Stubs a toggle that reports [saved] and updates the stored names.
  void stubToggle({
    required ComponentType type,
    required String name,
    required bool saved,
  }) {
    when(() => repository.toggleFavorite(type: type, name: name))
        .thenReturn(saved);
    when(() => repository.getSavedComponentNames(type))
        .thenReturn(saved ? <String>[name] : <String>[]);
  }

  group('SaveButtonWidget', () {
    testWidgets('shows the empty bookmark when not saved', (tester) async {
      await tester.pumpApp(scope());

      expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
      expect(find.byIcon(Icons.bookmark), findsNothing);
    });

    testWidgets('fills the bookmark and shows a snack bar when saved',
        (tester) async {
      when(
        () => repository.toggleFavorite(
          type: ComponentType.widget,
          name: 'Container',
        ),
      ).thenReturn(true);

      await tester.pumpApp(scope());

      when(() => repository.getSavedComponentNames(ComponentType.widget))
          .thenReturn(['Container']);
      await tester.tap(find.byIcon(Icons.bookmark_border));
      await tester.pump();

      expect(find.byIcon(Icons.bookmark), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows the filled bookmark when already saved', (tester) async {
      when(() => repository.getSavedComponentNames(ComponentType.widget))
          .thenReturn(['Container']);

      await tester.pumpApp(scope());

      expect(find.byIcon(Icons.bookmark), findsOneWidget);
      expect(find.byIcon(Icons.bookmark_border), findsNothing);
    });

    testWidgets('empties the bookmark when removed', (tester) async {
      when(() => repository.getSavedComponentNames(ComponentType.widget))
          .thenReturn(['Container']);

      await tester.pumpApp(scope());

      stubToggle(
        type: ComponentType.widget,
        name: 'Container',
        saved: false,
      );
      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pump();

      expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('switches the tooltip between save and remove', (tester) async {
      await tester.pumpApp(scope());

      final l10n = AppLocalizations.of(
        tester.element(find.byType(SaveButtonWidget)),
      )!;

      expect(
        tester.widget<IconButtonWidget>(find.byType(IconButtonWidget)).tooltip,
        l10n.save,
      );

      stubToggle(type: ComponentType.widget, name: 'Container', saved: true);
      await tester.tap(find.byIcon(Icons.bookmark_border));
      await tester.pump();

      expect(
        tester.widget<IconButtonWidget>(find.byType(IconButtonWidget)).tooltip,
        l10n.remove,
      );
    });
  });

  group('SaveButtonWidget messages', () {
    /// Taps the button and returns the localizations in scope.
    Future<AppLocalizations> toggle(
      WidgetTester tester, {
      required ComponentType type,
      required String name,
      required bool saved,
    }) async {
      when(() => repository.getSavedComponentNames(type))
          .thenReturn(saved ? <String>[] : <String>[name]);

      await tester.pumpApp(scope(componentType: type, componentName: name));

      final l10n = AppLocalizations.of(
        tester.element(find.byType(SaveButtonWidget)),
      )!;

      stubToggle(type: type, name: name, saved: saved);
      await tester.tap(find.byType(IconButtonWidget));
      await tester.pump();

      return l10n;
    }

    testWidgets('confirms a saved widget', (tester) async {
      final l10n = await toggle(
        tester,
        type: ComponentType.widget,
        name: 'Container',
        saved: true,
      );

      expect(find.text(l10n.savedWidget), findsOneWidget);
    });

    testWidgets('confirms a saved function', (tester) async {
      final l10n = await toggle(
        tester,
        type: ComponentType.function,
        name: 'showDialog',
        saved: true,
      );

      expect(find.text(l10n.savedFunction), findsOneWidget);
    });

    testWidgets('confirms a saved package', (tester) async {
      final l10n = await toggle(
        tester,
        type: ComponentType.package,
        name: 'dio',
        saved: true,
      );

      expect(find.text(l10n.savedPackage), findsOneWidget);
    });

    testWidgets('confirms a removed widget', (tester) async {
      final l10n = await toggle(
        tester,
        type: ComponentType.widget,
        name: 'Container',
        saved: false,
      );

      expect(find.text(l10n.widgetRemoved), findsOneWidget);
    });

    testWidgets('confirms a removed function', (tester) async {
      final l10n = await toggle(
        tester,
        type: ComponentType.function,
        name: 'showDialog',
        saved: false,
      );

      expect(find.text(l10n.functionRemoved), findsOneWidget);
    });

    testWidgets('confirms a removed package', (tester) async {
      final l10n = await toggle(
        tester,
        type: ComponentType.package,
        name: 'dio',
        saved: false,
      );

      expect(find.text(l10n.packageRemoved), findsOneWidget);
    });
  });
}

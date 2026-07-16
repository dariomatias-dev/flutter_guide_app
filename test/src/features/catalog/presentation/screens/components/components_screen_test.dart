import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/components_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../helpers/mocks.dart';
import '../../../../../../helpers/pump_app.dart';

const _componentsA = <Component>[
  Component(name: 'Alpha', type: ComponentType.widget),
  Component(name: 'Beta', type: ComponentType.widget),
];

const _componentsB = <Component>[
  Component(name: 'Alpha', type: ComponentType.widget),
  Component(name: 'Beta', type: ComponentType.widget),
  Component(name: 'Betamax', type: ComponentType.widget),
  Component(name: 'Gamma', type: ComponentType.widget),
];

void main() {
  late MockFavoritesRepository repository;

  setUpAll(() {
    registerFallbackValue(ComponentType.widget);
  });

  setUp(() {
    repository = MockFavoritesRepository();
    when(() => repository.getSavedComponentNames(any())).thenReturn([]);
  });

  Widget scope(List<Component> components) => ProviderScope(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(repository),
        ],
        child: ComponentsScreen(
          key: const ValueKey(ComponentType.widget),
          componentType: ComponentType.widget,
          components: components,
        ),
      );

  testWidgets(
    'search text and filter survive when components list changes '
    'without a new key',
    (tester) async {
      await tester.pumpApp(scope(_componentsA));

      await tester.enterText(find.byType(TextFormField), 'Beta');
      await tester.pump();

      expect(find.text('Alpha'), findsNothing);
      expect(find.text('Beta'), findsWidgets);

      // Same key rebuilding with an updated components list, as production
      // call sites now do (e.g. a favorite toggled elsewhere).
      await tester.pumpApp(scope(_componentsB));
      await tester.pump();

      final fieldText = tester
          .widget<TextFormField>(find.byType(TextFormField))
          .controller!
          .text;
      expect(fieldText, 'Beta');

      expect(find.text('Alpha'), findsNothing);
      expect(find.text('Gamma'), findsNothing);
      expect(find.text('Beta'), findsWidgets);

      // "Betamax" matches the still-active "Beta" query and only exists in
      // the NEW components list — it must show up without retyping,
      // proving the filtered `_items` actually resynced instead of holding
      // a stale snapshot computed from the old `widget.components`.
      expect(find.text('Betamax'), findsOneWidget);

      // Clearing the search must reveal Gamma too.
      await tester.enterText(find.byType(TextFormField), '');
      await tester.pump();

      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Beta'), findsOneWidget);
      expect(find.text('Betamax'), findsOneWidget);
      expect(find.text('Gamma'), findsOneWidget);
    },
  );
}

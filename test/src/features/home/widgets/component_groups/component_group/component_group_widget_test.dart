import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';
import 'package:flutter_guide/src/features/home/widgets/component_groups/component_group/component_group_widget.dart';
import 'package:flutter_guide/src/features/home/widgets/component_groups/component_group_model.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../helpers/mocks.dart';
import '../../../../../../helpers/pump_app.dart';

void main() {
  late MockComponentsRepository componentsRepository;
  late MockFavoritesRepository favoritesRepository;

  setUpAll(() {
    registerFallbackValue(ComponentType.widget);
  });

  setUp(() {
    componentsRepository = MockComponentsRepository();
    when(
      () => componentsRepository.getComponentByName(
        type: any(named: 'type'),
        name: any(named: 'name'),
      ),
    ).thenAnswer(
      (invocation) => Component(
        name: invocation.namedArguments[#name] as String,
        type: ComponentType.widget,
      ),
    );

    favoritesRepository = MockFavoritesRepository();
    when(
      () => favoritesRepository.getSavedComponentNames(any()),
    ).thenReturn([]);
  });

  final componentGroup = ComponentGroupModel(
    icon: Icons.widgets,
    title: (l10n) => 'Layout',
    components: const ['Column', 'Row'],
  );

  Widget scope() => ProviderScope(
    overrides: [
      componentsRepositoryProvider.overrideWithValue(componentsRepository),
      favoritesRepositoryProvider.overrideWithValue(favoritesRepository),
    ],
    child: ComponentGroupWidget(componentGroup: componentGroup),
  );

  group('ComponentGroupWidget', () {
    testWidgets('starts collapsed', (tester) async {
      await tester.pumpApp(scope());

      expect(find.text('Layout'), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_right_rounded), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNothing);
    });

    testWidgets('expands on tap, animating its components into view', (
      tester,
    ) async {
      await tester.pumpApp(scope());

      await tester.tap(find.text('Layout'));
      await tester.pump();

      // The list is always built, behind a SizeTransition; tapping starts
      // the animation rather than mounting the cards, so this only proves
      // the tap was handled without waiting out the whole animation.
      expect(find.byType(CardWidget), findsNWidgets(2));

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsOneWidget);
    });

    testWidgets('collapses again on a second tap', (tester) async {
      await tester.pumpApp(scope());

      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Layout'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.keyboard_arrow_right_rounded), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNothing);
    });
  });
}

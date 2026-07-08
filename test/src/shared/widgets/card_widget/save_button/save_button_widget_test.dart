import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/save_button/save_button_widget.dart';
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

  Widget scope() => ProviderScope(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(repository),
        ],
        child: const SaveButtonWidget(
          componentType: ComponentType.widget,
          componentName: 'Container',
        ),
      );

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
  });
}

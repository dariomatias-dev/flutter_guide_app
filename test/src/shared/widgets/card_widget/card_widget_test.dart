import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/save_button/save_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late MockFavoritesRepository repository;

  setUpAll(() {
    registerFallbackValue(ComponentType.widget);
  });

  setUp(() {
    repository = MockFavoritesRepository();
    when(() => repository.getSavedComponentNames(any())).thenReturn([]);
  });

  Widget scope({String? videoId}) => ProviderScope(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(repository),
        ],
        child: CardWidget(
          icon: Icons.star,
          componentName: 'Container',
          componentType: ComponentType.widget,
          videoId: videoId,
        ),
      );

  group('CardWidget', () {
    testWidgets('renders the name, icon and save button', (tester) async {
      await tester.pumpApp(scope());

      expect(find.text('Container'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byType(SaveButtonWidget), findsOneWidget);
    });

    testWidgets('omits the video button when videoId is null', (tester) async {
      await tester.pumpApp(scope());

      expect(find.byType(FaIcon), findsNothing);
    });

    testWidgets('shows the video button when videoId is set', (tester) async {
      await tester.pumpApp(scope(videoId: 'abc123'));

      expect(find.byType(FaIcon), findsOneWidget);
    });
  });
}

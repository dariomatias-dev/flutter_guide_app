import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/save_button/save_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/pump_app.dart';
import '../../../../helpers/url_launcher_fake.dart';

void main() {
  late MockFavoritesRepository repository;

  setUpAll(() {
    registerFallbackValue(ComponentType.widget);
  });

  setUp(() {
    repository = MockFavoritesRepository();
    when(() => repository.getSavedComponentNames(any())).thenReturn([]);
  });

  Widget scope({String? videoId, EdgeInsets? padding}) => ProviderScope(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(repository),
        ],
        child: CardWidget(
          icon: Icons.star,
          componentName: 'Container',
          componentType: ComponentType.widget,
          videoId: videoId,
          padding: padding,
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

    testWidgets('opens the YouTube url for the videoId', (tester) async {
      final urlLauncher = FakeUrlLauncherPlatform()..install();
      addTearDown(urlLauncher.restore);

      await tester.pumpApp(scope(videoId: 'abc123'));

      await tester.tap(find.byType(FaIcon));
      await tester.pumpAndSettle();

      expect(
        urlLauncher.launchedUrls,
        <String>['https://www.youtube.com/watch?v=abc123'],
      );
    });

    testWidgets('labels the video button', (tester) async {
      await tester.pumpApp(scope(videoId: 'abc123'));

      final l10n = AppLocalizations.of(
        tester.element(find.byType(CardWidget)),
      )!;

      expect(find.byTooltip(l10n.watchOnYoutube), findsOneWidget);
    });

    testWidgets('applies the given padding', (tester) async {
      const padding = EdgeInsets.all(24);

      await tester.pumpApp(scope(padding: padding));

      final item = tester.widget<ListTileItemWidget>(
        find.byType(ListTileItemWidget),
      );

      expect(item.padding, padding);
    });
  });
}

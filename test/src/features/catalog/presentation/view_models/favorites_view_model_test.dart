import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_view_model_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/view_models/favorites_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/mocks.dart';

void main() {
  late MockFavoritesRepository repository;

  setUpAll(() {
    registerFallbackValue(ComponentType.widget);
  });

  setUp(() {
    repository = MockFavoritesRepository();
    when(() => repository.getSavedComponentNames(any())).thenReturn([]);
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        favoritesRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  FavoritesViewModel notifier(ProviderContainer c) =>
      c.read(favoritesViewModelProvider.notifier);

  group('FavoritesViewModel', () {
    group('build', () {
      test('seeds the tracked types from the repository', () {
        when(() => repository.getSavedComponentNames(ComponentType.widget))
            .thenReturn(['Container']);
        when(() => repository.getSavedComponentNames(ComponentType.function))
            .thenReturn(['showDialog']);

        final state = makeContainer().read(favoritesViewModelProvider);

        expect(state[ComponentType.widget], {'Container'});
        expect(state[ComponentType.function], {'showDialog'});
        expect(state[ComponentType.package], isEmpty);
      });
    });

    group('isFavorite', () {
      test('returns true for a seeded name', () {
        when(() => repository.getSavedComponentNames(ComponentType.widget))
            .thenReturn(['Container']);

        final vm = notifier(makeContainer());

        expect(
          vm.isFavorite(type: ComponentType.widget, name: 'Container'),
          isTrue,
        );
      });

      test('returns false for an unknown name', () {
        final vm = notifier(makeContainer());

        expect(
          vm.isFavorite(type: ComponentType.widget, name: 'Unknown'),
          isFalse,
        );
      });
    });

    group('toggle', () {
      test('delegates to the repository and refreshes state', () {
        when(
          () => repository.toggleFavorite(
            type: ComponentType.widget,
            name: 'Container',
          ),
        ).thenReturn(true);

        final container = makeContainer();
        final vm = notifier(container);

        when(() => repository.getSavedComponentNames(ComponentType.widget))
            .thenReturn(['Container']);
        final saved = vm.toggle(type: ComponentType.widget, name: 'Container');

        expect(saved, isTrue);
        expect(
          container.read(favoritesViewModelProvider)[ComponentType.widget],
          {'Container'},
        );
        verify(
          () => repository.toggleFavorite(
            type: ComponentType.widget,
            name: 'Container',
          ),
        ).called(1);
      });
    });
  });
}

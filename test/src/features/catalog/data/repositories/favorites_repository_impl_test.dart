import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/repositories/favorites_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/mocks.dart';

void main() {
  late MockFavoritesLocalDatasource datasource;
  late FavoritesRepositoryImpl repository;

  setUp(() {
    datasource = MockFavoritesLocalDatasource();
    repository = FavoritesRepositoryImpl(datasource);
  });

  group('FavoritesRepositoryImpl', () {
    test('isFavorite delegates to the datasource', () {
      when(
        () => datasource.contains(
          type: ComponentType.widget,
          name: 'Container',
        ),
      ).thenReturn(true);

      final result = repository.isFavorite(
        type: ComponentType.widget,
        name: 'Container',
      );

      expect(result, isTrue);
      verify(
        () => datasource.contains(
          type: ComponentType.widget,
          name: 'Container',
        ),
      ).called(1);
    });

    test('toggleFavorite delegates to the datasource', () {
      when(
        () => datasource.toggle(
          type: ComponentType.function,
          name: 'showDialog',
        ),
      ).thenReturn(true);

      final result = repository.toggleFavorite(
        type: ComponentType.function,
        name: 'showDialog',
      );

      expect(result, isTrue);
      verify(
        () => datasource.toggle(
          type: ComponentType.function,
          name: 'showDialog',
        ),
      ).called(1);
    });

    test('getSavedComponentNames delegates to the datasource', () {
      when(() => datasource.getSavedNames(ComponentType.package))
          .thenReturn(['dio']);

      final result = repository.getSavedComponentNames(ComponentType.package);

      expect(result, ['dio']);
      verify(() => datasource.getSavedNames(ComponentType.package)).called(1);
    });
  });
}

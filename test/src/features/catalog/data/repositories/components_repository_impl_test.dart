import 'dart:ui';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/repositories/components_repository_impl.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/mocks.dart';

void main() {
  const locale = Locale('en');
  late MockComponentsLocalDatasource datasource;
  late ComponentsRepositoryImpl repository;

  setUp(() {
    datasource = MockComponentsLocalDatasource();
    repository = ComponentsRepositoryImpl(
      datasource: datasource,
      locale: locale,
    );
  });

  group('ComponentsRepositoryImpl', () {
    test('getComponentsByType delegates with the injected locale', () {
      const components = [
        Component(name: 'Container', type: ComponentType.widget),
      ];
      when(() => datasource.getByType(ComponentType.widget, locale: locale))
          .thenReturn(components);

      final result = repository.getComponentsByType(ComponentType.widget);

      expect(result, components);
      verify(
        () => datasource.getByType(ComponentType.widget, locale: locale),
      ).called(1);
    });

    test('getComponentByName delegates with the injected locale', () {
      const component = Component(
        name: 'Container',
        type: ComponentType.widget,
      );
      when(
        () => datasource.getByName(
          type: ComponentType.widget,
          name: 'Container',
          locale: locale,
        ),
      ).thenReturn(component);

      final result = repository.getComponentByName(
        type: ComponentType.widget,
        name: 'Container',
      );

      expect(result, component);
      verify(
        () => datasource.getByName(
          type: ComponentType.widget,
          name: 'Container',
          locale: locale,
        ),
      ).called(1);
    });
  });
}

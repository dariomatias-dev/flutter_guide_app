import 'dart:ui';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/components_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const locale = Locale('en');
  late ComponentsLocalDatasource datasource;

  setUp(() {
    datasource = ComponentsLocalDatasource();
  });

  group('ComponentsLocalDatasource', () {
    group('getByType', () {
      test('returns a non-empty list for every type', () {
        for (final type in ComponentType.values) {
          expect(
            datasource.getByType(type, locale: locale),
            isNotEmpty,
            reason: '$type should resolve to at least one component',
          );
        }
      });

      test('tags every returned component with the requested type', () {
        final elements =
            datasource.getByType(ComponentType.elements, locale: locale);

        expect(
          elements.every((c) => c.type == ComponentType.elements),
          isTrue,
        );
      });
    });

    group('getByName', () {
      test('returns the component matching the given name', () {
        final first =
            datasource.getByType(ComponentType.widget, locale: locale).first;

        final found = datasource.getByName(
          type: ComponentType.widget,
          name: first.name,
          locale: locale,
        );

        expect(found.name, first.name);
        expect(found.type, first.type);
      });

      test('throws when no component matches the name', () {
        expect(
          () => datasource.getByName(
            type: ComponentType.widget,
            name: '__missing__',
            locale: locale,
          ),
          throwsStateError,
        );
      });
    });
  });
}

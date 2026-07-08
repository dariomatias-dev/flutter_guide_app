import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/favorites_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late FavoritesLocalDatasource datasource;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();
    datasource = FavoritesLocalDatasource(SharedPreferencesService(prefs));
  });

  group('FavoritesLocalDatasource', () {
    group('getSavedNames', () {
      test('returns empty list when nothing saved', () {
        expect(datasource.getSavedNames(ComponentType.widget), isEmpty);
      });
    });

    group('toggle', () {
      test('adds the name and returns true on first toggle', () {
        final saved = datasource.toggle(
          type: ComponentType.widget,
          name: 'Container',
        );

        expect(saved, isTrue);
        expect(
          datasource.contains(type: ComponentType.widget, name: 'Container'),
          isTrue,
        );
      });

      test('removes the name and returns false on second toggle', () {
        datasource.toggle(type: ComponentType.widget, name: 'Container');

        final saved = datasource.toggle(
          type: ComponentType.widget,
          name: 'Container',
        );

        expect(saved, isFalse);
        expect(
          datasource.contains(type: ComponentType.widget, name: 'Container'),
          isFalse,
        );
      });
    });

    group('contains', () {
      test('returns false for an unsaved name', () {
        expect(
          datasource.contains(type: ComponentType.package, name: 'dio'),
          isFalse,
        );
      });
    });

    group('key mapping', () {
      test('function and package use separate keys', () {
        datasource.toggle(type: ComponentType.function, name: 'showDialog');

        expect(
          datasource.getSavedNames(ComponentType.package),
          isEmpty,
        );
        expect(
          datasource.getSavedNames(ComponentType.function),
          ['showDialog'],
        );
      });

      test('widget, material, cupertino, elements and uis share one key', () {
        datasource.toggle(type: ComponentType.widget, name: 'Container');

        for (final type in [
          ComponentType.widget,
          ComponentType.material,
          ComponentType.cupertino,
          ComponentType.elements,
          ComponentType.uis,
        ]) {
          expect(
            datasource.contains(type: type, name: 'Container'),
            isTrue,
            reason: '$type should read the shared widget key',
          );
        }
      });
    });
  });
}

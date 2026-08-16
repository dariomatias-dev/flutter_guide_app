import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/models/component_model.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/functions.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/packages.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/widgets.dart'
    as widgets_source;
import 'package:flutter_guide/src/features/catalog/data/samples/sample_names/function_names.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_names/package_names.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_names/widget_names.dart';
import 'package:flutter_guide/src/features/catalog/presentation/samples/sample_registry.dart';
import 'package:flutter_test/flutter_test.dart';

/// The sample lists [SampleRegistry] resolves against, keyed by source name.
const _sampleLists = <String, List<ComponentModel>>{
  'functions': functions,
  'packages': packages,
  'widgets': widgets_source.widgets,
};

/// Component types that [SampleRegistry] refuses to resolve.
const _unsupportedTypes = <ComponentType>[
  ComponentType.elements,
  ComponentType.uis,
];

void main() {
  group('SampleRegistry.resolve', () {
    test('resolves a function sample by name', () {
      const name = FunctionNames.showAboutDialogMaterial;

      final resolved = SampleRegistry.resolve(
        type: ComponentType.function,
        name: name,
      );

      expect(
        resolved,
        same(
          functions.firstWhere((component) => component.name == name).sample,
        ),
      );
    });

    test('resolves a package sample by name', () {
      const name = PackageNames.awesomeSnackbarContentPackage;

      final resolved = SampleRegistry.resolve(
        type: ComponentType.package,
        name: name,
      );

      expect(
        resolved,
        same(packages.firstWhere((component) => component.name == name).sample),
      );
    });

    test('resolves widget, material and cupertino from the widget list', () {
      const name = WidgetNames.alignWidget;

      final expected = widgets_source.widgets
          .firstWhere((component) => component.name == name)
          .sample;

      for (final type in <ComponentType>[
        ComponentType.widget,
        ComponentType.material,
        ComponentType.cupertino,
      ]) {
        expect(
          SampleRegistry.resolve(type: type, name: name),
          same(expected),
          reason: '$type should resolve against the widget list',
        );
      }
    });

    test('resolves a material component looked up as a widget', () {
      // Material and Cupertino entries live in the same list as plain
      // widgets, so the declared type must not narrow the lookup.
      const name = WidgetNames.actionChipMaterial;

      expect(
        SampleRegistry.resolve(type: ComponentType.widget, name: name),
        same(
          widgets_source.widgets
              .firstWhere((component) => component.name == name)
              .sample,
        ),
      );
    });

    test('throws when the name is unknown', () {
      for (final type in <ComponentType>[
        ComponentType.function,
        ComponentType.package,
        ComponentType.widget,
        ComponentType.material,
        ComponentType.cupertino,
      ]) {
        expect(
          () => SampleRegistry.resolve(type: type, name: 'DoesNotExist'),
          throwsStateError,
          reason: '$type should reject an unknown name',
        );
      }
    });

    for (final type in _unsupportedTypes) {
      test('throws UnsupportedError for $type', () {
        expect(
          () => SampleRegistry.resolve(type: type, name: 'anything'),
          throwsUnsupportedError,
        );
      });
    }

    test('resolves every registered component', () {
      for (final entry in _sampleLists.entries) {
        for (final component in entry.value) {
          expect(
            () => SampleRegistry.resolve(
              type: component.type,
              name: component.name,
            ),
            returnsNormally,
            reason: '${entry.key}: "${component.name}" is not resolvable',
          );
        }
      }
    });
  });

  group('sample definitions', () {
    test('every list is non-empty', () {
      for (final entry in _sampleLists.entries) {
        expect(entry.value, isNotEmpty, reason: '${entry.key} is empty');
      }
    });

    test('names are unique within each list', () {
      for (final entry in _sampleLists.entries) {
        final names = entry.value.map((component) => component.name).toList();

        expect(
          names.toSet(),
          hasLength(names.length),
          reason: '${entry.key} has duplicate names, which would shadow a '
              'sample during lookup',
        );
      }
    });

    test('functions are all typed as functions', () {
      expect(
        functions.every(
          (component) => component.type == ComponentType.function,
        ),
        isTrue,
      );
    });

    test('packages are all typed as packages', () {
      expect(
        packages.every((component) => component.type == ComponentType.package),
        isTrue,
      );
    });

    test('widgets are typed as widget, material or cupertino', () {
      const allowedTypes = <ComponentType>{
        ComponentType.widget,
        ComponentType.material,
        ComponentType.cupertino,
      };

      for (final component in widgets_source.widgets) {
        expect(
          allowedTypes,
          contains(component.type),
          reason: '"${component.name}" has an unresolvable type',
        );
      }
    });
  });
}

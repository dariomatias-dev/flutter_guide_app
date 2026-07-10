import 'package:flutter/material.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_paths.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_args.dart';

/// Resolves the [ComponentSampleArgs] used to render a component sample.
///
/// Centralizes the construction of [ComponentSampleArgs] — including the
/// sample file path — so `ComponentScreen` and `InterfaceCatalogScreen`
/// share a single point of assembly instead of each building it by hand.
abstract final class ComponentSampleArgsResolver {
  /// Builds the [ComponentSampleArgs] for a sample located at
  /// `sample_components/$folder/${fileName}_sample.dart`.
  static ComponentSampleArgs resolve({
    required String title,
    required String folder,
    required String fileName,
    required String componentName,
    required Widget sample,
    List<PopupMenuEntry<dynamic>>? popupMenuItems,
  }) {
    return ComponentSampleArgs(
      title: title,
      filePath: resolveSampleFilePath(folder: folder, fileName: fileName),
      componentName: componentName,
      sample: sample,
      popupMenuItems: popupMenuItems,
    );
  }
}

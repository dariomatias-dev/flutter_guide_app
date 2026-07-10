import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_paths.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/samples/sample_registry.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/widgets/doc_popup_menu_item/doc_popup_menu_item_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/widgets/favorite_popup_menu_item/favorite_popup_menu_item_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen shown for a single component, hosting its sample and actions.
class ComponentScreen extends ConsumerWidget {
  /// Creates a [ComponentScreen].
  const ComponentScreen({
    required this.componentType,
    required this.componentName,
    super.key,
  });

  /// Category of the component being shown.
  final ComponentType componentType;

  /// Name of the component being shown.
  final String componentName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(componentsRepositoryProvider);

    final component = repository.getComponentByName(
      type: componentType,
      name: componentName,
    );

    final docType =
        componentType == ComponentType.package ? null : component.type;

    late final String folderName;
    switch (componentType) {
      case ComponentType.widget:
        folderName = 'widgets';
      case ComponentType.package:
        folderName = 'packages';
      case ComponentType.material:
      case ComponentType.cupertino:
      case ComponentType.function:
        folderName = 'functions';
      case ComponentType.elements:
      case ComponentType.uis:
        throw StateError(
          '$componentType belongs to InterfaceCatalogScreen, '
          'not ComponentScreen',
        );
    }

    return ComponentSampleScreen(
      title: component.name,
      filePath: resolveSampleFilePath(
        folder: folderName,
        fileName: componentName.toLowerCase(),
      ),
      componentName: componentName,
      sample: SampleRegistry.resolve(
        type: componentType,
        name: componentName,
      ),
      popupMenuItems: <PopupMenuEntry<dynamic>>[
        FavoritePopupMenuItemWidget(
          componentType: componentType,
          componentName: component.name,
        ),
        if (component.videoId != null)
          PopupMenuItem<void>(
            onTap: () {
              unawaited(
                openUrl(
                  () => context,
                  'https://www.youtube.com/watch?v=${component.videoId}',
                ),
              );
            },
            child: const Text('YouTube'),
          ),
        DocPopupMenuItemWidget(
          componentName: component.name,
          type: docType,
        ),
      ],
    );
  }
}

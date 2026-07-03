import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/widgets/doc_popup_menu_item/doc_popup_menu_item_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/widgets/favorite_popup_menu_item/favorite_popup_menu_item_widget.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/component_sample_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComponentScreen extends ConsumerWidget {
  const ComponentScreen({
    super.key,
    required this.componentType,
    required this.componentName,
  });

  final ComponentType componentType;
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
      default:
        folderName = 'functions';
    }

    return ComponentSampleScreen(
      title: component.name,
      filePath:
          'lib/src/core/constants/samples/sample_components/$folderName/${componentName.toLowerCase()}_sample.dart',
      componentName: componentName,
      sample: repository.getSampleWidget(
        type: componentType,
        name: componentName,
      ),
      popupMenuItems: <PopupMenuEntry>[
        FavoritePopupMenuItemWidget(
          componentType: componentType,
          componentName: component.name,
        ),
        if (component.videoId != null)
          PopupMenuItem(
            onTap: () {
              openUrl(
                () => context,
                'https://www.youtube.com/watch?v=${component.videoId}',
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

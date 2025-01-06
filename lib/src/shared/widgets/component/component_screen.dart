import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/component/component_controller.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/shared/widgets/component/widgets/doc_popup_menu_item/doc_popup_menu_item_widget.dart';
import 'package:flutter_guide/src/shared/widgets/component/widgets/favorite_popup_menu_item/favorite_popup_menu_item_widget.dart';

class ComponentScreen extends StatefulWidget {
  const ComponentScreen({
    super.key,
    required this.componentType,
    required this.componentName,
  });

  final ComponentType componentType;
  final String componentName;

  @override
  State<ComponentScreen> createState() => _ComponentScreenState();
}

class _ComponentScreenState extends State<ComponentScreen> {
  late ComponentController _controller;

  @override
  void didChangeDependencies() {
    _controller = ComponentController(
      context: context,
      componentType: widget.componentType,
      componentName: widget.componentName,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    late final String folderName;
    switch (widget.componentType) {
      case ComponentType.widget:
        folderName = 'widgets';
      case ComponentType.package:
        folderName = 'packages';
      default:
        folderName = 'functions';
    }

    return ComponentSampleScreen(
      title: _controller.component.name,
      filePath:
          'lib/src/shared/widgets/component/samples/$folderName/${widget.componentName.toLowerCase()}_sample.dart',
      sample: _controller.component.sample,
      popupMenuItems: <PopupMenuEntry>[
        FavoritePopupMenuItemWidget(
          componentType: widget.componentType,
          componentName: _controller.component.name,
        ),
        if (_controller.component.videoId != null)
          PopupMenuItem(
            onTap: () {
              openUrl(
                () => context,
                'https://www.youtube.com/watch?v=${_controller.component.videoId}',
              );
            },
            child: const Text('YouTube'),
          ),
        DocPopupMenuItemWidget(
          componentName: _controller.component.name,
          type: _controller.type,
        ),
      ],
    );
  }
}

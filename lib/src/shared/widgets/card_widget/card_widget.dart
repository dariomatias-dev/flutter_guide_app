import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/router/app_routes.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/save_button/save_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Catalog card linking to a component, with optional video and save button.
class CardWidget extends StatelessWidget {
  /// Creates a [CardWidget].
  const CardWidget({
    required this.icon,
    required this.componentName,
    required this.componentType,
    super.key,
    this.videoId,
    this.padding,
  });

  /// Leading icon for the component.
  final IconData icon;

  /// Display name of the component.
  final String componentName;

  /// Category of the component.
  final ComponentType componentType;

  /// Optional YouTube video id for the component.
  final String? videoId;

  /// Optional outer padding.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ListTileItemWidget(
      onTap: () {
        AppRoutes.pushComponent(
          context,
          type: componentType,
          name: componentName,
        );
      },
      padding: padding,
      title: componentName,
      icon: icon,
      trailingWidgets: <Widget>[
        if (videoId != null) ...<Widget>[
          IconButtonWidget(
            child: FaIcon(
              FontAwesomeIcons.youtube,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            onTap: () {
              unawaited(
                openUrl(
                  () => context,
                  'https://www.youtube.com/watch?v=${videoId!}',
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
        SaveButtonWidget(
          componentType: componentType,
          componentName: componentName,
        ),
      ],
    );
  }
}

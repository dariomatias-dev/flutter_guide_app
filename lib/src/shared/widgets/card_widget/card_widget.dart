import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/router/app_routes.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/save_button/save_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.icon,
    required this.componentName,
    required this.componentType,
    this.videoId,
    this.padding,
  });

  final IconData icon;
  final String componentName;
  final ComponentType componentType;
  final String? videoId;

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
              size: 24.0,
            ),
            onTap: () {
              openUrl(
                () => context,
                'https://www.youtube.com/watch?v=${videoId!}',
              );
            },
          ),
          const SizedBox(width: 4.0),
        ],
        SaveButtonWidget(
          componentType: componentType,
          componentName: componentName,
        ),
      ],
    );
  }
}

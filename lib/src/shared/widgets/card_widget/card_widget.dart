import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/favorite_notifier/favorite_notifier.dart';

import 'package:flutter_guide/src/services/bookmarker_service/favorites_service.dart';

import 'package:flutter_guide/src/shared/utils/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/save_button/save_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/component/component_screen.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.icon,
    required this.componentName,
    required this.componentType,
    this.videoId,
    required this.favoritesService,
    required this.favoriteNotifier,
    this.padding,
  });

  final IconData icon;
  final String componentName;
  final ComponentType componentType;
  final String? videoId;

  final FavoritesService favoritesService;
  final FavoriteNotifier favoriteNotifier;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ListTileItemWidget(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ComponentScreen(
                componentType: componentType,
                componentName: componentName,
              );
            },
          ),
        );
      },
      padding: padding,
      title: componentName,
      icon: icon,
      trailingWidgets: <Widget>[
        if (videoId != null) ...<Widget>[
          IconButtonWidget(
            icon: FontAwesomeIcons.youtube,
            onTap: () {
              openUrl(
                () => context,
                'https://www.youtube.com/watch?v=${videoId!}',
              );
            },
          ),
          const SizedBox(width: 12.0),
        ],
        SaveButtonWidget(
          componentName: componentName,
          favoritesService: favoritesService,
          favoriteNotifier: favoriteNotifier,
        ),
      ],
    );
  }
}

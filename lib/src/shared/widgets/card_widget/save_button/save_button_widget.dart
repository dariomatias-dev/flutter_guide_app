import 'package:flutter/material.dart';

import 'package:flutter_guide/src/providers/favorite_notifier/favorite_notifier.dart';

import 'package:flutter_guide/src/services/bookmarker_service/favorites_service.dart';

import 'package:flutter_guide/src/shared/widgets/card_widget/save_button/save_button_controller.dart';
import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';

class SaveButtonWidget extends StatefulWidget {
  const SaveButtonWidget({
    super.key,
    required this.componentName,
    required this.favoritesService,
    required this.favoriteNotifier,
  });

  final String componentName;

  final FavoritesService favoritesService;
  final FavoriteNotifier favoriteNotifier;

  @override
  State<SaveButtonWidget> createState() => _SaveButtonWidgetState();
}

class _SaveButtonWidgetState extends State<SaveButtonWidget> {
  late final _controller = SaveButtonController(
    context: context,
    componentName: widget.componentName,
    favoritesService: widget.favoritesService,
    favoriteNotifier: widget.favoriteNotifier,
  );

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      onTap: () {
        _controller.ontap(
          context,
          widget.componentName,
        );
      },
      child: ValueListenableBuilder(
        valueListenable: widget.favoriteNotifier,
        builder: (context, value, child) {
          _controller.setSaved(
            widget.componentName,
          );

          return Icon(
            _controller.saved ? Icons.bookmark : Icons.bookmark_border,
            color: Theme.of(context).colorScheme.primary,
            size: 24.0,
          );
        },
      ),
    );
  }
}

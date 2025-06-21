import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/shared/widgets/component/widgets/favorite_popup_menu_item/favorite_popup_menu_item_controller.dart';

class FavoritePopupMenuItemWidget extends PopupMenuEntry {
  const FavoritePopupMenuItemWidget({
    super.key,
    required this.componentType,
    required this.componentName,
  });

  final ComponentType componentType;
  final String componentName;

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(value) => false;

  @override
  State<FavoritePopupMenuItemWidget> createState() =>
      FavoritePopupMenuItemWidgetState();
}

class FavoritePopupMenuItemWidgetState
    extends State<FavoritePopupMenuItemWidget> {
  late final _controller = FavoritePopupMenuItemController(
    context: context,
    componentType: widget.componentType,
    componentName: widget.componentName,
  );

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return PopupMenuItem(
      onTap: () {
        _controller.saved = _controller.favoritesService.toggleWidgetState(
          context,
          widget.componentName,
        );

        _controller.favoriteNotifier.setValue(widget.componentName);
      },
      child: Text(
        _controller.saved ? appLocalizations.remove : appLocalizations.save,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/features/main/widgets/main_app_bar/select_favorite_screen_dialog/select_favorite_screen_dialog_controller.dart';

import 'package:flutter_guide/src/shared/widgets/custom_dialog/custom_dialog.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

class SelectFavoriteScreenDialogWidget extends StatefulWidget {
  const SelectFavoriteScreenDialogWidget({
    super.key,
    this.overlayEntry,
  });

  final OverlayEntry? overlayEntry;

  @override
  State<SelectFavoriteScreenDialogWidget> createState() =>
      _SelectFavoriteScreenDialogWidgetState();
}

class _SelectFavoriteScreenDialogWidgetState
    extends State<SelectFavoriteScreenDialogWidget> {
  late final _controller = SelectFavoriteScreenDialogController(
    context: context,
  );

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return CustomDialog.dialog(
      title: appLocalizations.favorites,
      children: <Widget>[
        ListTileItemWidget(
          onTap: () {
            widget.overlayEntry?.remove();

            _controller.navigateTo(
              ComponentType.widget,
            );
          },
          title: 'Widgets',
          icon: Icons.extension_outlined,
        ),
        ListTileItemWidget(
          onTap: () {
            widget.overlayEntry?.remove();

            _controller.navigateTo(
              ComponentType.function,
            );
          },
          title: appLocalizations.functions,
          icon: Icons.extension_outlined,
        ),
        ListTileItemWidget(
          onTap: () {
            widget.overlayEntry?.remove();

            _controller.navigateTo(
              ComponentType.package,
            );
          },
          title: appLocalizations.packages,
          icon: Icons.archive_outlined,
        ),
      ],
      isActionFullWidth: true,
      actions: <ActionButtonWidget>[
        CustomDialog.button(
          text: 'Ok',
          onTap: () {
            widget.overlayEntry?.remove();
          },
        ),
      ],
    );
  }
}

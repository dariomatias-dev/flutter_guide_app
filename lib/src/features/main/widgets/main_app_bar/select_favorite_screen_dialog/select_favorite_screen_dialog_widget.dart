import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/features/main/widgets/main_app_bar/select_favorite_screen_dialog/select_favorite_screen_dialog_controller.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_widget.dart';

import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

class SelectFavoriteScreenDialogWidget extends StatefulWidget {
  const SelectFavoriteScreenDialogWidget({super.key});

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

    return DialogWidget(
      title: appLocalizations.favorites,
      actions: <DialogButtonWidget>[
        DialogButtonWidget(
          onTap: () {
            Navigator.pop(context);
          },
          text: 'Ok',
        ),
      ],
      children: <Widget>[
        ListTileItemWidget(
          onTap: () {
            Navigator.pop(context);

            _controller.navigateTo(
              ComponentType.widget,
            );
          },
          title: 'Widgets',
          icon: Icons.extension_outlined,
        ),
        ListTileItemWidget(
          onTap: () {
            Navigator.pop(context);

            _controller.navigateTo(
              ComponentType.function,
            );
          },
          title: appLocalizations.functions,
          icon: Icons.extension_outlined,
        ),
        ListTileItemWidget(
          onTap: () {
            Navigator.pop(context);

            _controller.navigateTo(
              ComponentType.package,
            );
          },
          title: appLocalizations.packages,
          icon: Icons.archive_outlined,
        ),
      ],
    );
  }
}

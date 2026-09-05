import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/navigation/navigators/catalog_navigator.dart';

import 'package:flutter_guide/src/shared/widgets/dialog/dialog_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_widget.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

/// Dialog letting the user pick which favorites list to open.
class SelectFavoriteScreenDialogWidget extends StatelessWidget {
  /// Creates a [SelectFavoriteScreenDialogWidget].
  const SelectFavoriteScreenDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return DialogWidget(
      title: appLocalizations.favorites,
      actions: <DialogButtonWidget>[
        DialogButtonWidget(
          onTap: () {
            Navigator.pop(context);
          },
          text: appLocalizations.ok,
        ),
      ],
      children: <Widget>[
        ListTileItemWidget(
          onTap: () {
            Navigator.pop(context);

            unawaited(
              SavedComponentsRoute(
                type: ComponentType.widget.name,
              ).push(context),
            );
          },
          title: appLocalizations.widgets,
          icon: Icons.extension_outlined,
        ),
        ListTileItemWidget(
          onTap: () {
            Navigator.pop(context);

            unawaited(
              SavedComponentsRoute(
                type: ComponentType.function.name,
              ).push(context),
            );
          },
          title: appLocalizations.functions,
          icon: Icons.extension_outlined,
        ),
        ListTileItemWidget(
          onTap: () {
            Navigator.pop(context);

            unawaited(
              SavedComponentsRoute(
                type: ComponentType.package.name,
              ).push(context),
            );
          },
          title: appLocalizations.packages,
          icon: Icons.archive_outlined,
        ),
      ],
    );
  }
}

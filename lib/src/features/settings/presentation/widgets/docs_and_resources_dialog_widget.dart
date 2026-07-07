import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/features/settings/data/datasources/docs_and_resources_datasource.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_widget.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

/// Dialog listing documentation and resource links.
class DocsAndResourcesDialogWidget extends StatelessWidget {
  /// Creates a [DocsAndResourcesDialogWidget].
  const DocsAndResourcesDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final docsAndResources = getDocsAndResources(context);

    return DialogWidget(
      title: AppLocalizations.of(context)!.docsAndResources,
      actions: <DialogButtonWidget>[
        DialogButtonWidget(
          onTap: () {
            Navigator.pop(context);
          },
          text: 'Ok',
        ),
      ],
      children: List.generate(
        docsAndResources.length,
        (index) {
          final item = docsAndResources[index];

          return ListTileItemWidget(
            onTap: () {
              unawaited(
                openUrl(
                  () => context,
                  item.url,
                ),
              );
            },
            icon: item.icon,
            title: item.name,
            openInBrowser: true,
          );
        },
      ),
    );
  }
}

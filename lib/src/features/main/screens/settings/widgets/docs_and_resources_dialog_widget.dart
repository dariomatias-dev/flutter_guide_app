import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/docs_and_resources_widget.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/dialogs/dialog_widget.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

class DocsAndResourcesDialogWidget extends StatelessWidget {
  const DocsAndResourcesDialogWidget({
    super.key,
    required this.overlayEntry,
  });

  final OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    final docsAndResources = getDocsAndResources(context);

    return DialogWidget(
      title: AppLocalizations.of(context)!.docsAndResources,
      content: Column(
        children: List.generate(
          docsAndResources.length,
          (index) {
            final item = docsAndResources[index];

            return ListTileItemWidget(
              onTap: () {
                openUrl(
                  () => context,
                  item.url,
                );
              },
              icon: item.icon,
              title: item.name,
              openInBrowser: true,
            );
          },
        ),
      ),
      actions: <Widget>[
        ButtonWidget(
          onTap: () {
            overlayEntry?.remove();
          },
          text: 'Ok',
        ),
      ],
    );
  }
}

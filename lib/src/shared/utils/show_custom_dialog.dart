import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/dialogs/dialog_screen_widget.dart';

void showCustomDialog({
  required BuildContext context,
  required Widget Function(
    OverlayEntry? overlayEntry,
  ) builder,
}) {
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return DialogScreenWidget(
        removeDocs: () {
          overlayEntry?.remove();
        },
        child: builder(
          overlayEntry,
        ),
      );
    },
  );

  Overlay.of(context).insert(
    overlayEntry,
  );
}

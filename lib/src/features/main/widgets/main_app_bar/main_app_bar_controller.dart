import 'package:flutter/material.dart';

import 'package:flutter_guide/src/features/main/widgets/main_app_bar/select_favorite_screen_dialog/select_favorite_screen_dialog_widget.dart';

class MainAppBarController {
  MainAppBarController({
    required BuildContext context,
  }) : _context = context;

  final BuildContext _context;

  void showSelectFavoriteScreenDialog() {
    showDialog(
      context: _context,
      builder: (context) {
        return const SelectFavoriteScreenDialogWidget();
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/shell/widgets/root_app_bar/select_favorite_screen_dialog/select_favorite_screen_dialog_widget.dart';

import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';

class RootAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const RootAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<RootAppBarWidget> createState() => _RootAppBarWidgetState();
}

class _RootAppBarWidgetState extends State<RootAppBarWidget> {
  void showSelectFavoriteScreenDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const SelectFavoriteScreenDialogWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StandardAppBarWidget(
      showBackButton: false,
      title: Row(
        children: <Widget>[
          Image.asset(
            'assets/icons/flutter_guide_icon.png',
            width: 20.0,
            height: 20.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16.0),
          const Text(
            'FlutterGuide',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButtonWidget(
          onTap: showSelectFavoriteScreenDialog,
          icon: Icons.bookmark_border,
        ),
        const SizedBox(width: 4.0),
      ],
    );
  }
}

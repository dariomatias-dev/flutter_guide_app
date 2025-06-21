import 'package:flutter/material.dart';

import 'package:flutter_guide/src/features/main/widgets/main_app_bar/main_app_bar_controller.dart';

import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';

class MainAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<MainAppBarWidget> createState() => _MainAppBarWidgetState();
}

class _MainAppBarWidgetState extends State<MainAppBarWidget> {
  late final _controller = MainAppBarController(
    context: context,
  );

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
          onTap: _controller.showSelectFavoriteScreenDialog,
          icon: Icons.bookmark_border,
        ),
        const SizedBox(width: 4.0),
      ],
    );
  }
}

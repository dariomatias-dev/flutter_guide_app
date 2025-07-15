import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/back_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/change_theme_button_widget.dart';

class StandardAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const StandardAppBarWidget({
    super.key,
    this.showBackButton = true,
    this.titleName,
    this.title,
    this.actions,
    this.bottom,
  }) : assert(
          !(titleName != null && title != null),
          'You may not supply both the name of the title and the title simultaneously.',
        );

  final bool showBackButton;
  final String? titleName;
  final Widget? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return AppBar(
      surfaceTintColor: secondaryColor,
      backgroundColor: secondaryColor,
      leading: showBackButton ? const BackButtonWidget() : null,
      title: title ??
          Text(
            titleName!,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
      actions: <Widget>[
        const ChangeThemeButtonWidget(),
        const SizedBox(width: 4.0),
        if (actions != null) ...actions!,
      ],
      bottom: bottom,
    );
  }
}

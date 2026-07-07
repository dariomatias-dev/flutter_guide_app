import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/back_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/change_theme_button_widget.dart';

/// App bar with a standard theme toggle and optional back button.
class StandardAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  /// Creates a [StandardAppBarWidget].
  const StandardAppBarWidget({
    super.key,
    this.showBackButton = true,
    this.titleName,
    this.title,
    this.actions,
    this.bottom,
  }) : assert(
          !(titleName != null && title != null),
          'You may not supply both the name of the title and the title '
          'simultaneously.',
        );

  /// Whether to show a leading back button.
  final bool showBackButton;

  /// Title text, mutually exclusive with [title].
  final String? titleName;

  /// Title widget, mutually exclusive with [titleName].
  final Widget? title;

  /// Optional trailing actions.
  final List<Widget>? actions;

  /// Optional widget shown below the app bar.
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize {
    return Size.fromHeight(
      kToolbarHeight + (bottom?.preferredSize.height ?? 0),
    );
  }

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
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
      actions: <Widget>[
        const ChangeThemeButtonWidget(),
        const SizedBox(width: 4),
        if (actions != null) ...actions!,
      ],
      bottom: bottom,
    );
  }
}

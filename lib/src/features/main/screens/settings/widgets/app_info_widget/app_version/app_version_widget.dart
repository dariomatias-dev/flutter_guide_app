import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/features/main/screens/settings/widgets/app_info_widget/app_version/app_version_controller.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

class AppVersionWidget extends StatefulWidget {
  const AppVersionWidget({super.key});

  @override
  State<AppVersionWidget> createState() => _AppVersionWidgetState();
}

class _AppVersionWidgetState extends State<AppVersionWidget> {
  final _controller = AppVersionController();

  @override
  void didChangeDependencies() {
    _controller.getAppVersion(
      context,
      () => setState(() {}),
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return ValueListenableBuilder(
      valueListenable: themeController,
      builder: (context, value, child) {
        return Text(
          '${AppLocalizations.of(context)!.version} ${_controller.version}',
          style: TextStyle(
            color: themeController.theme.textTheme.bodyMedium?.color ??
                Colors.black,
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}

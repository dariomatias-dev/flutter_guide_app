import 'package:flutter/material.dart';

import 'package:flutter_guide/src/features/main/screens/settings/widgets/app_info_widget/app_version/app_version_widget.dart';
import 'package:flutter_guide/src/features/main/screens/settings/widgets/app_info_widget/source_code_button_widget.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

class AppInfoWidget extends StatelessWidget {
  const AppInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/icons/flutter_guide_icon.png',
            width: 52.0,
            height: 52.0,
          ),
          const SizedBox(height: 16.0),
          ValueListenableBuilder(
            valueListenable: themeController,
            builder: (context, value, child) {
              return Text(
                'FlutterGuide',
                style: TextStyle(
                  color: themeController.theme.textTheme.bodyMedium?.color ??
                      Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
          const AppVersionWidget(),
          const SizedBox(height: 20.0),
          const SourceCodeButtonWidget(),
        ],
      ),
    );
  }
}

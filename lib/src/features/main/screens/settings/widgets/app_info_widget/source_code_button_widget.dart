import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';

class SourceCodeButtonWidget extends StatelessWidget {
  const SourceCodeButtonWidget({super.key});

  BorderRadius get borderRadius => BorderRadius.circular(20.0);

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return ValueListenableBuilder(
      valueListenable: themeController,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 36.0,
          ),
          child: InkWell(
            onTap: () {
              openUrl(
                () => context,
                'https://github.com/dariomatias-dev/flutter_guide',
              );
            },
            borderRadius: borderRadius,
            overlayColor: WidgetStatePropertyAll(
              Colors.blue.withOpacity(
                themeController.isLight ? 0.06 : 0.11,
              ),
            ),
            hoverColor: Colors.blue.withOpacity(
              themeController.isLight ? 0.055 : 0.105,
            ),
            child: Ink(
              width: double.infinity,
              height: 40.0,
              decoration: BoxDecoration(
                color: themeController.theme.colorScheme.secondary,
                borderRadius: borderRadius,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(
                    themeController.isLight ? 0.05 : 0.1,
                  ),
                  borderRadius: borderRadius,
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.sourceCode,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

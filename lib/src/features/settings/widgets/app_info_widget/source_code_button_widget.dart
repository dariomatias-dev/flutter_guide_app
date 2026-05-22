import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/links/app_links.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';

class SourceCodeButtonWidget extends StatelessWidget {
  const SourceCodeButtonWidget({super.key});

  BorderRadius get borderRadius => BorderRadius.circular(20.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36.0,
      ),
      child: InkWell(
        onTap: () {
          openUrl(
            () => context,
            AppLinks.repository,
          );
        },
        borderRadius: borderRadius,
        overlayColor: WidgetStatePropertyAll(
          Colors.blue.withAlpha(
            isDark ? 28 : 15,
          ),
        ),
        hoverColor: Colors.blue.withAlpha(
          isDark ? 27 : 14,
        ),
        child: Ink(
          width: double.infinity,
          height: 40.0,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: borderRadius,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(
                isDark ? 26 : 15,
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
  }
}

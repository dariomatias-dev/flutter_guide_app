import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/constants/links/app_links.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';

/// Button that opens the app's source code repository.
class SourceCodeButtonWidget extends StatelessWidget {
  /// Creates a [SourceCodeButtonWidget].
  const SourceCodeButtonWidget({super.key});

  /// Corner radius of the button.
  BorderRadius get borderRadius => BorderRadius.circular(20);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
      ),
      child: InkWell(
        onTap: () {
          unawaited(
            openUrl(
              () => context,
              AppLinks.repository,
            ),
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
          height: 40,
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

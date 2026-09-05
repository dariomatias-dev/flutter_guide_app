import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/theme/theme.dart';

/// The failure an [AppFailureScreen] is reporting.
enum AppFailureKind {
  /// The app could not finish starting up, so there is no app to show.
  startup,

  /// A part of a running app failed to build.
  unexpected,
}

/// A failure screen that stands on its own, outside the app's widget tree.
///
/// [ErrorWidget.builder] is invoked at the point of failure, which can sit
/// above `MaterialApp` when the root itself throws, and the startup fallback
/// runs before there is an app at all. Neither can read a [Theme], a
/// [Directionality] or an [AppLocalizations] from an ancestor that may not
/// exist, and reading one that is missing would throw from inside the screen
/// that exists to report the throw: all three are resolved from the platform
/// instead. The text direction is fixed rather than derived, since every
/// supported locale is left to right.
class AppFailureScreen extends StatelessWidget {
  /// Creates an [AppFailureScreen].
  const AppFailureScreen({
    required this.kind,
    this.onRetry,
    this.technicalDetails,
    super.key,
  });

  /// Which failure to describe.
  final AppFailureKind kind;

  /// Called when the retry action is tapped. When `null`, no retry action is
  /// shown.
  final VoidCallback? onRetry;

  /// Technical failure details, shown in debug builds only.
  ///
  /// A stack trace in a release build tells the user nothing and exposes
  /// internals, so it is dropped there.
  final String? technicalDetails;

  @override
  Widget build(BuildContext context) {
    final localizations = _localizations();
    final dispatcher = WidgetsBinding.instance.platformDispatcher;
    final theme = dispatcher.platformBrightness == Brightness.dark
        ? darkMode
        : lightMode;
    final retry = onRetry;
    final details = technicalDetails;

    final title = switch (kind) {
      AppFailureKind.startup => localizations.startupErrorTitle,
      AppFailureKind.unexpected => localizations.unexpectedErrorTitle,
    };
    final message = switch (kind) {
      AppFailureKind.startup => localizations.startupErrorMessage,
      AppFailureKind.unexpected => localizations.unexpectedErrorMessage,
    };

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Theme(
        data: theme,
        child: Material(
          color: theme.scaffoldBackgroundColor,
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                    if (retry != null) ...[
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: retry,
                        child: Text(localizations.retry),
                      ),
                    ],
                    if (details != null && kDebugMode) ...[
                      const SizedBox(height: 24),
                      Text(
                        details,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// The localizations for the device's language, falling back to English.
  ///
  /// [lookupAppLocalizations] throws on an unsupported locale, which on a
  /// screen that exists to report a failure would replace it with another one.
  AppLocalizations _localizations() {
    final languageCode =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final supported = AppLocalizations.supportedLocales.any(
      (locale) => locale.languageCode == languageCode,
    );

    return lookupAppLocalizations(Locale(supported ? languageCode : 'en'));
  }
}

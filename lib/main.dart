import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/config/app_env_providers.dart';
import 'package:flutter_guide/src/core/config/dotenv_app_env.dart';
import 'package:flutter_guide/src/core/di/logger_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/errors/error_handlers.dart';
import 'package:flutter_guide/src/core/errors/error_reporter.dart';
import 'package:flutter_guide/src/core/widgets/app_failure_screen.dart';
import 'package:flutter_guide/src/flutter_guide_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _logger = Logger();
final _reporter = LoggerErrorReporter(_logger);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Installed before anything that can fail, so a failure in startup itself
  // is reported rather than printed and lost.
  installErrorHandlers(_reporter);

  ErrorWidget.builder = (details) => AppFailureScreen(
    kind: AppFailureKind.unexpected,
    technicalDetails: details.exceptionAsString(),
  );

  await _start();
}

/// Initializes what the app cannot run without, then hands the tree to
/// [runApp].
///
/// Each step below can fail on a real device: an `.env` asset that is not
/// there, storage that refuses to open, an ad SDK that throws on init. Left
/// unguarded, any of them aborts before [runApp] and leaves a black screen
/// with nothing to act on, so a failure surfaces as a screen offering to run
/// the whole sequence again.
Future<void> _start() async {
  try {
    final appEnv = DotenvAppEnv();
    await appEnv.load();

    final sharedPreferences = await SharedPreferences.getInstance();

    unawaited(MobileAds.instance.initialize());
    unawaited(
      MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: appEnv.testDeviceIds),
      ),
    );

    runApp(
      ProviderScope(
        overrides: [
          appEnvProvider.overrideWithValue(appEnv),
          loggerProvider.overrideWithValue(_logger),
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: const FlutterGuideApp(),
      ),
    );
  } on Object catch (error, stackTrace) {
    _reporter.report(error, stackTrace, context: 'Startup failed');

    runApp(
      AppFailureScreen(
        kind: AppFailureKind.startup,
        onRetry: () => unawaited(_start()),
        technicalDetails: error.toString(),
      ),
    );
  }
}

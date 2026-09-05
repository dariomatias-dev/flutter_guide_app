import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/config/app_env_providers.dart';
import 'package:flutter_guide/src/core/config/dotenv_app_env.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/flutter_guide_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appEnv = DotenvAppEnv();
  await appEnv.load();

  final requestConfiguration = RequestConfiguration(
    testDeviceIds: appEnv.testDeviceIds,
  );

  unawaited(MobileAds.instance.initialize());
  unawaited(
    MobileAds.instance.updateRequestConfiguration(requestConfiguration),
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        appEnvProvider.overrideWithValue(appEnv),
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const FlutterGuideApp(),
    ),
  );
}

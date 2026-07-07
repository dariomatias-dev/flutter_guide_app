import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/flutter_guide_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
    
  );

  final requestConfiguration = RequestConfiguration(
    testDeviceIds: <String>[
      dotenv.get('DEVICE_ID'),
    ],
  );

  unawaited(MobileAds.instance.initialize());
  unawaited(
    MobileAds.instance.updateRequestConfiguration(requestConfiguration),
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const FlutterGuideApp(),
    ),
  );
}

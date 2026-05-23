import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/notifiers/app_version_notifier.dart';

final appVersionNotifierProvider =
    AsyncNotifierProvider<AppVersionNotifier, String>(
  AppVersionNotifier.new,
);

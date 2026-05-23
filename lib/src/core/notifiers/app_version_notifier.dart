import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final info = await PackageInfo.fromPlatform();

    return '${info.version}+${info.buildNumber}';
  }
}

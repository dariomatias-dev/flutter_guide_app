import 'package:package_info_plus/package_info_plus.dart';

/// Default app version lookup backed by `package_info_plus`.
Future<String> getAppVersion() async {
  final info = await PackageInfo.fromPlatform();

  return '${info.version}+${info.buildNumber}';
}

import 'package:flutter_guide/src/features/settings/domain/repositories/app_version_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Default [AppVersionRepository] backed by `package_info_plus`.
class AppVersionRepositoryImpl implements AppVersionRepository {
  @override
  Future<String> getAppVersion() async {
    final info = await PackageInfo.fromPlatform();

    return '${info.version}+${info.buildNumber}';
  }
}

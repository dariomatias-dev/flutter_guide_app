import 'package:flutter_guide/src/features/settings/data/repositories/app_version_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  group('getAppVersion', () {
    test('combines the version and build number from the platform', () async {
      PackageInfo.setMockInitialValues(
        appName: 'FlutterGuide',
        packageName: 'com.dariomatias.flutter_guide',
        version: '1.3.0',
        buildNumber: '19',
        buildSignature: '',
      );

      expect(await getAppVersion(), '1.3.0+19');
    });
  });
}

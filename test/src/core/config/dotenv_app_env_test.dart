import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_guide/src/core/config/dotenv_app_env.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DotEnv environment;
  late DotenvAppEnv appEnv;

  setUp(() {
    environment = DotEnv();
    appEnv = DotenvAppEnv(environment: environment);
  });

  group('DotenvAppEnv', () {
    test('reads the configured values', () {
      environment.testLoad(
        fileInput: 'DEVICE_ID=abc123\nBANNER_AD_ID=ca-app-pub-1/2',
      );

      expect(appEnv.bannerAdUnitId, 'ca-app-pub-1/2');
      expect(appEnv.testDeviceIds, <String>['abc123']);
    });

    test('treats a missing key as an absent value', () {
      environment.testLoad();

      expect(appEnv.bannerAdUnitId, isNull);
      expect(appEnv.testDeviceIds, isEmpty);
    });

    test('treats an empty value as absent', () {
      // The .env file CI writes carries every key with no value.
      environment.testLoad(fileInput: 'DEVICE_ID=\nBANNER_AD_ID=');

      expect(appEnv.bannerAdUnitId, isNull);
      expect(appEnv.testDeviceIds, isEmpty);
    });

    test('load survives a missing file', () async {
      // Without this, dotenv throws before runApp and the app dies at boot
      // with a black screen.
      final missing = DotenvAppEnv(
        environment: environment,
        fileName: 'does_not_exist.env',
      );

      await expectLater(missing.load(), completes);

      expect(missing.bannerAdUnitId, isNull);
      expect(missing.testDeviceIds, isEmpty);
    });
  });
}

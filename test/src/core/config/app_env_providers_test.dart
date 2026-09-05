import 'package:flutter_guide/src/core/config/app_env_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_app_env.dart';

void main() {
  group('appEnvProvider', () {
    test('throws when left un-overridden', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // main.dart always overrides this with the environment startup
      // loaded; reading it bare is a wiring mistake the provider itself
      // should catch.
      expect(
        () => container.read(appEnvProvider),
        throwsA(
          isA<Object>().having(
            (error) => error.toString(),
            'message',
            contains('appEnvProvider must be overridden'),
          ),
        ),
      );
    });

    test('exposes the overridden environment', () {
      const env = FakeAppEnv(bannerAdUnitId: 'ca-app-pub-1');
      final container = ProviderContainer(
        overrides: [appEnvProvider.overrideWithValue(env)],
      );
      addTearDown(container.dispose);

      expect(container.read(appEnvProvider), same(env));
    });
  });
}

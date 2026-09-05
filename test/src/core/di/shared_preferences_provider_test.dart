import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('sharedPreferencesProvider', () {
    test('throws when left un-overridden', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // main.dart always overrides this with the instance startup awaited;
      // reading it bare is a wiring mistake the provider itself should catch.
      expect(
        () => container.read(sharedPreferencesProvider),
        throwsA(
          isA<Object>().having(
            (error) => error.toString(),
            'message',
            contains('UnimplementedError'),
          ),
        ),
      );
    });
  });

  group('sharedPreferencesServiceProvider', () {
    test('wraps the overridden preferences instance', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );
      addTearDown(container.dispose);

      expect(container.read(sharedPreferencesServiceProvider), isNotNull);
    });
  });
}

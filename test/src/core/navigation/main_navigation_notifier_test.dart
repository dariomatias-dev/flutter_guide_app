import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/navigation/main_navigation_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  MainNavigationNotifier notifier() =>
      container.read(mainNavigationNotifierProvider.notifier);

  group('MainNavigationNotifier', () {
    test('starts at index 0', () {
      expect(container.read(mainNavigationNotifierProvider), 0);
    });

    test('index setter updates the state', () {
      notifier().index = 2;

      expect(container.read(mainNavigationNotifierProvider), 2);
      expect(notifier().index, 2);
    });

    test('reset returns to index 0', () {
      notifier().index = 3;

      notifier().reset();

      expect(container.read(mainNavigationNotifierProvider), 0);
    });
  });
}

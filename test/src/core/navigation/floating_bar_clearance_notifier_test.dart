import 'package:flutter_guide/src/core/di/floating_bar_clearance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FloatingBarClearanceNotifier', () {
    test('starts at 0, before anything has been measured', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(floatingBarClearanceProvider), 0);
    });

    test('update sets the measured clearance', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(floatingBarClearanceProvider.notifier).update(84);

      expect(container.read(floatingBarClearanceProvider), 84);
    });

    test('update is a no-op when the value has not changed', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      var rebuilds = 0;
      container.listen(
        floatingBarClearanceProvider,
        (previous, next) => rebuilds++,
      );

      container.read(floatingBarClearanceProvider.notifier).update(84);
      container.read(floatingBarClearanceProvider.notifier).update(84);

      // A second call with the same value schedules no further build, which
      // matters here because the caller runs it from every layout.
      expect(rebuilds, 1);
    });
  });
}

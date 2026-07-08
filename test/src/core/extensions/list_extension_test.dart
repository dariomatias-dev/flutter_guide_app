import 'package:flutter_guide/src/core/extensions/list_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ListExtension.builder', () {
    test('maps each element together with its index', () {
      final result = ['a', 'b', 'c'].builder((e, index) => '$index:$e');

      expect(result, ['0:a', '1:b', '2:c']);
    });

    test('returns an empty list for an empty source', () {
      final result = <int>[].builder((e, index) => e * 2);

      expect(result, isEmpty);
    });

    test('preserves the source order', () {
      final result = [10, 20, 30].builder((e, index) => e + index);

      expect(result, [10, 21, 32]);
    });

    test('can map to a different type', () {
      final result = [1, 2].builder((e, index) => e.isEven);

      expect(result, [false, true]);
    });
  });
}

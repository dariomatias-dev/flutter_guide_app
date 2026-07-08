import 'package:flutter_guide/src/features/catalog/presentation/providers/elements_screen_tab_index_notifier_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/view_models/elements_screen_tab_index_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  ElementsScreenTabIndexNotifier notifier() =>
      container.read(elementsScreenTabIndexNotifierProvider.notifier);

  group('ElementsScreenTabIndexNotifier', () {
    test('starts at index 0', () {
      expect(container.read(elementsScreenTabIndexNotifierProvider), 0);
    });

    test('index setter updates the state', () {
      notifier().index = 1;

      expect(container.read(elementsScreenTabIndexNotifierProvider), 1);
      expect(notifier().index, 1);
    });
  });
}

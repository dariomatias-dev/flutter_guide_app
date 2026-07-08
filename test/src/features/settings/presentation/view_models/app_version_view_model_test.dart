import 'package:flutter_guide/src/features/settings/presentation/providers/app_version_repository_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/app_version_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ProviderContainer makeContainer(Future<String> Function() repository) {
    final container = ProviderContainer(
      overrides: [
        appVersionRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('AppVersionViewModel', () {
    test('build resolves the version from the repository', () async {
      final container = makeContainer(() async => '1.2.3+18');

      final version = await container.read(appVersionViewModelProvider.future);

      expect(version, '1.2.3+18');
    });
  });
}

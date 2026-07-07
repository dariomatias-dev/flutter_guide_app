import 'package:flutter_guide/src/features/settings/domain/repositories/app_version_repository.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/app_version_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Asynchronously exposes the app version string.
class AppVersionViewModel extends AsyncNotifier<String> {
  late final AppVersionRepository _repository = ref.read(
    appVersionRepositoryProvider,
  );

  @override
  Future<String> build() {
    return _repository.getAppVersion();
  }
}

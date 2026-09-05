import 'package:flutter_guide/src/features/settings/data/repositories/app_version_repository_impl.dart';
import 'package:flutter_guide/src/features/settings/domain/repositories/app_version_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the [AppVersionRepository].
final appVersionRepositoryProvider = Provider<AppVersionRepository>((ref) {
  return getAppVersion;
});

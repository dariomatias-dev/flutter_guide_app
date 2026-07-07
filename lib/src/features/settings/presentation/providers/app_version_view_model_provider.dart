import 'package:flutter_guide/src/features/settings/presentation/view_models/app_version_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the [AppVersionViewModel].
final appVersionViewModelProvider =
    AsyncNotifierProvider<AppVersionViewModel, String>(
  AppVersionViewModel.new,
);

import 'package:flutter_guide/src/features/settings/presentation/view_models/settings_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsViewModelProvider = Provider<SettingsViewModel>((ref) {
  return SettingsViewModel();
});

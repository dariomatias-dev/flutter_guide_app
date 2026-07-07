import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the [SharedPreferences] instance.
///
/// Overridden at app start with the real instance.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

/// Provides the [SharedPreferencesService] wrapper.
final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>((
  ref,
) {
  final prefs = ref.watch(sharedPreferencesProvider);

  return SharedPreferencesService(prefs);
});

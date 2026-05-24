import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';

class LanguageNotifier extends Notifier<String> {
  late final _preferences = ref.read(sharedPreferencesServiceProvider);

  @override
  String build() {
    return _preferences.getString(
      SharedPreferencesKeys.languageKey,
      defaultValue: LanguagesApp.en,
    );
  }

  Future<void> setLanguage(String language) async {
    state = language;

    await _preferences.setString(
      SharedPreferencesKeys.languageKey,
      language,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_guide/src/core/constants/languages.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/models/language_model.dart';

class SelectLanguageController {
  SelectLanguageController({
    required BuildContext context,
  }) {
    _init(context);
  }

  late final UserPreferencesInheritedWidget _userPreferencesInheritedWidget;
  late final SharedPreferences _sharedPreferences;

  late final ValueNotifier<LanguageModel> selectedLanguageNotifier;

  void _init(
    BuildContext context,
  ) {
    _userPreferencesInheritedWidget =
        UserPreferencesInheritedWidget.of(context)!;
    _sharedPreferences = _userPreferencesInheritedWidget.sharedPreferences;

    final selectedLanguageName = _sharedPreferences.getString(
          SharedPreferencesKeys.languageKey,
        ) ??
        '';

    LanguageModel? selectedLanguage;

    for (final language in languages) {
      if (selectedLanguageName == language.code) {
        selectedLanguage = language;
        break;
      }
    }

    selectedLanguage ??= languages.first;

    selectedLanguageNotifier = ValueNotifier(
      selectedLanguage,
    );
  }

  void showLanguageMenu(
    BuildContext context,
    VoidCallback setStateCallback,
  ) {
    final button = context.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(
          button.size.topRight(Offset.zero),
          ancestor: overlay,
        ),
        button.localToGlobal(
          button.size.topRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: List.generate(
        languages.length,
        (index) {
          final language = languages[index];

          return PopupMenuItem(
            onTap: () {
              UserPreferencesInheritedWidget.of(context)!
                  .languageNotifier
                  .value = language.code;

              selectedLanguageNotifier.value = language;

              _sharedPreferences.setString(
                SharedPreferencesKeys.languageKey,
                language.code,
              );

              setStateCallback();
            },
            value: language,
            child: Text(
              language.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14.0,
              ),
            ),
          );
        },
      ),
      elevation: 8.0,
    );
  }
}

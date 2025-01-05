import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/components/packages.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/features/elements/elements_screen.dart';
import 'package:flutter_guide/src/features/main/screens/home/home_screen.dart';
import 'package:flutter_guide/src/features/main/screens/settings/settings_screen.dart';

import 'package:flutter_guide/src/shared/models/screen_model.dart';
import 'package:flutter_guide/src/shared/widgets/components/components_screen.dart';

List<ScreenModel> getBottomAppBarScreens(
  BuildContext context,
) {
  final appLocalizations = AppLocalizations.of(context)!;

  return <ScreenModel>[
    ScreenModel(
      bottomNavigationBarName: appLocalizations.home,
      screen: const HomeScreen(),
    ),
    ScreenModel(
      bottomNavigationBarName: appLocalizations.elements,
      screen: const ElementsScreen(),
    ),
    ScreenModel(
      bottomNavigationBarName: appLocalizations.packages,
      screen: const ComponentsScreen(
        componentType: ComponentType.package,
        components: packages,
      ),
    ),
    ScreenModel(
      bottomNavigationBarName: appLocalizations.settings,
      screen: const SettingsScreen(),
    ),
  ];
}

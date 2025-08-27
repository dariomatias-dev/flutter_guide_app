import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';

import 'package:flutter_guide/src/features/main/screens/home/widgets/border_list_tile_item_widget.dart';
import 'package:flutter_guide/src/features/main/screens/home/widgets/component_groups/component_groups_widget.dart';

import 'package:flutter_guide/src/shared/utils/navigate_to.dart';
import 'package:flutter_guide/src/shared/widgets/interface_catalog/interface_catalog_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
      ),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 20.0),
          BorderListTileItemWidget(
            title: appLocalizations.elements,
            icon: Icons.list_alt,
            onTap: () {
              navigateTo(
                context,
                const InterfaceCatalogScreen(
                  elementType: InterfaceTypeEnum.element,
                ),
              );
            },
          ),
          const SizedBox(height: 8.0),
          BorderListTileItemWidget(
            title: 'UIs',
            icon: Icons.web,
            onTap: () {
              navigateTo(
                context,
                const InterfaceCatalogScreen(
                  elementType: InterfaceTypeEnum.ui,
                ),
              );
            },
          ),
          const SizedBox(height: 8.0),
          BorderListTileItemWidget(
            title: appLocalizations.templates,
            icon: Icons.insert_drive_file_outlined,
            onTap: () {
              navigateTo(
                context,
                const InterfaceCatalogScreen(
                  elementType: InterfaceTypeEnum.template,
                ),
              );
            },
          ),
          const SizedBox(height: 20.0),
          const ComponentGroupsWidget(),
          const SizedBox(height: 92.0),
        ],
      ),
    );
  }
}

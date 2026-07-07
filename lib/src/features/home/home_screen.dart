import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/router/app_routes.dart';
import 'package:flutter_guide/src/features/home/widgets/border_list_tile_item_widget.dart';
import 'package:flutter_guide/src/features/home/widgets/component_groups/component_groups_widget.dart';

/// Home tab: entry points to elements, UIs and component groups.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
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
          const SizedBox(height: 20),
          BorderListTileItemWidget(
            title: appLocalizations.elements,
            icon: Icons.list_alt,
            onTap: () => AppRoutes.pushCatalog(
              context,
              interfaceType: InterfaceTypeEnum.element,
            ),
          ),
          const SizedBox(height: 8),
          BorderListTileItemWidget(
            title: 'UIs',
            icon: Icons.web,
            onTap: () => AppRoutes.pushCatalog(
              context,
              interfaceType: InterfaceTypeEnum.ui,
            ),
          ),
          const SizedBox(height: 20),
          const ComponentGroupsWidget(),
          const SizedBox(height: 92),
        ],
      ),
    );
  }
}

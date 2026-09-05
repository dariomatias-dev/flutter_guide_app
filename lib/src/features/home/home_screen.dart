import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/floating_bar_clearance_provider.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/router/app_routes.dart';
import 'package:flutter_guide/src/features/home/widgets/border_list_tile_item_widget.dart';
import 'package:flutter_guide/src/features/home/widgets/component_groups/component_groups_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Home tab: entry points to elements, UIs and component groups.
class HomeScreen extends ConsumerWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    final floatingBarClearance = ref.watch(floatingBarClearanceProvider);

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
            title: appLocalizations.uis,
            icon: Icons.web,
            onTap: () => AppRoutes.pushCatalog(
              context,
              interfaceType: InterfaceTypeEnum.ui,
            ),
          ),
          const SizedBox(height: 20),
          const ComponentGroupsWidget(),
          // Keeps the last item clear of the floating bottom bar, whose
          // height depends on the text scale and whose margin depends on
          // gesture vs. 3-button system navigation.
          SizedBox(height: floatingBarClearance),
        ],
      ),
    );
  }
}

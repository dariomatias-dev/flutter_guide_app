import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/router/app_routes.dart';
import 'package:flutter_guide/src/features/catalog/data/models/interface_model.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/elements.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/uis.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_args_resolver.dart';
import 'package:flutter_guide/src/features/catalog/presentation/widgets/infinity_scroll.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';

/// Lists reusable elements or full UI samples for a given interface type.
class InterfaceCatalogScreen extends StatelessWidget {
  /// Creates an [InterfaceCatalogScreen].
  const InterfaceCatalogScreen({
    required this.elementType,
    super.key,
  });

  /// Whether to show elements or UIs.
  final InterfaceTypeEnum elementType;

  @override
  Widget build(BuildContext context) {
    late final String title;
    late final String componentType;
    late final List<InterfaceModel> items;

    final appLocalizations = AppLocalizations.of(context)!;

    switch (elementType) {
      case InterfaceTypeEnum.element:
        title = appLocalizations.elements;
        componentType = 'elements';
        items = getElements(context);
      case InterfaceTypeEnum.ui:
        title = appLocalizations.uis;
        componentType = 'uis';
        items = getUis(context);
    }

    return Scaffold(
      appBar: StandardAppBarWidget(
        titleName: title,
      ),
      body: InfinityScroll<InterfaceModel>(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        items: items,
        itemBuilder: (value) {
          return ListTileItemWidget(
            onTap: () {
              AppRoutes.pushComponentSample(
                context,
                args: ComponentSampleArgsResolver.resolve(
                  title: value.name,
                  folder: componentType,
                  fileName: value.fileName,
                  componentName: value.fileName,
                  sample: value.sample,
                ),
              );
            },
            title: value.name,
            trailingWidgets: const <Widget>[
              Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 26,
              ),
            ],
          );
        },
      ),
    );
  }
}

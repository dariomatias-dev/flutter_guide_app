import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/functions.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/packages.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/widgets.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_view_model_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/components_screen.dart';
import 'package:flutter_guide/src/shared/models/component_model.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedComponentsScreen extends ConsumerWidget {
  const SavedComponentsScreen({
    super.key,
    required this.componentType,
  });

  final ComponentType componentType;

  List<ComponentModel> get _groupOfComponents {
    switch (componentType) {
      case ComponentType.widget:
        return widgets;
      case ComponentType.function:
        return functions;
      default:
        return packages;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context)!;

    late final String titleScreen;
    late final String missingElementsMessage;
    switch (componentType) {
      case ComponentType.widget:
        titleScreen = appLocalizations.savedWidgets;
        missingElementsMessage = appLocalizations.noWidgetSaved;
      case ComponentType.function:
        titleScreen = appLocalizations.savedFunctions;
        missingElementsMessage = appLocalizations.noFunctionSaved;
      default:
        titleScreen = appLocalizations.savedPackages;
        missingElementsMessage = appLocalizations.noPackageSaved;
    }

    final savedNames = ref.watch(
      favoritesViewModelProvider.select(
        (state) => state[componentType] ?? const <String>{},
      ),
    );

    final components = _groupOfComponents
        .where((component) => savedNames.contains(component.name))
        .toList();

    return Scaffold(
      appBar: StandardAppBarWidget(
        titleName: titleScreen,
      ),
      body: components.isNotEmpty
          ? ComponentsScreen(
              key: UniqueKey(),
              componentType: componentType,
              components: components,
            )
          : Center(
              child: Text(missingElementsMessage),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_view_model_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/components_screen.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen listing the user's saved components of a given type.
class SavedComponentsScreen extends ConsumerWidget {
  /// Creates a [SavedComponentsScreen].
  const SavedComponentsScreen({
    required this.componentType,
    super.key,
  });

  /// Category of saved components to show.
  final ComponentType componentType;

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
      case ComponentType.material:
      case ComponentType.cupertino:
      case ComponentType.package:
      case ComponentType.elements:
      case ComponentType.uis:
        titleScreen = appLocalizations.savedPackages;
        missingElementsMessage = appLocalizations.noPackageSaved;
    }

    final savedNames = ref.watch(
      favoritesViewModelProvider.select(
        (state) => state[componentType] ?? const <String>{},
      ),
    );

    final components = ref
        .watch(componentsRepositoryProvider)
        .getComponentsByType(componentType)
        .where((component) => savedNames.contains(component.name))
        .toList();

    return Scaffold(
      appBar: StandardAppBarWidget(
        titleName: titleScreen,
      ),
      body: components.isNotEmpty
          ? ComponentsScreen(
              key: ValueKey(componentType),
              componentType: componentType,
              components: components,
            )
          : Center(
              child: Text(missingElementsMessage),
            ),
    );
  }
}

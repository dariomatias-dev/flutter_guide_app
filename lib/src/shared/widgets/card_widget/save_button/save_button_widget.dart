import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_view_model_provider.dart';

import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';
import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';

class SaveButtonWidget extends ConsumerWidget {
  const SaveButtonWidget({
    super.key,
    required this.componentType,
    required this.componentName,
  });

  final ComponentType componentType;
  final String componentName;

  String _savedMessage(AppLocalizations l10n) {
    switch (componentType) {
      case ComponentType.function:
        return l10n.savedFunction;
      case ComponentType.package:
        return l10n.savedPackage;
      default:
        return l10n.savedWidget;
    }
  }

  String _removedMessage(AppLocalizations l10n) {
    switch (componentType) {
      case ComponentType.function:
        return l10n.functionRemoved;
      case ComponentType.package:
        return l10n.packageRemoved;
      default:
        return l10n.widgetRemoved;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(
      favoritesViewModelProvider.select(
        (state) => state[componentType]?.contains(componentName) ?? false,
      ),
    );

    return IconButtonWidget(
      onTap: () {
        final isSaved = ref
            .read(favoritesViewModelProvider.notifier)
            .toggle(type: componentType, name: componentName);

        final l10n = AppLocalizations.of(context)!;

        SnackBarUtils.show(
          context,
          isSaved ? _savedMessage(l10n) : _removedMessage(l10n),
        );
      },
      child: Icon(
        saved ? Icons.bookmark : Icons.bookmark_border,
        color: Theme.of(context).colorScheme.primary,
        size: 24.0,
      ),
    );
  }
}

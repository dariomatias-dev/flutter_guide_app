import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePopupMenuItemWidget extends PopupMenuEntry {
  const FavoritePopupMenuItemWidget({
    super.key,
    required this.componentType,
    required this.componentName,
  });

  final ComponentType componentType;
  final String componentName;

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(value) => false;

  @override
  State<FavoritePopupMenuItemWidget> createState() =>
      _FavoritePopupMenuItemWidgetState();
}

class _FavoritePopupMenuItemWidgetState
    extends State<FavoritePopupMenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isSaved = ref.watch(
          favoritesViewModelProvider.select(
            (state) =>
                state[widget.componentType]?.contains(widget.componentName) ??
                false,
          ),
        );

        final appLocalizations = AppLocalizations.of(context)!;

        return PopupMenuItem(
          onTap: () {
            ref.read(favoritesViewModelProvider.notifier).toggle(
                  type: widget.componentType,
                  name: widget.componentName,
                );
          },
          child: Text(
            isSaved ? appLocalizations.remove : appLocalizations.save,
          ),
        );
      },
    );
  }
}

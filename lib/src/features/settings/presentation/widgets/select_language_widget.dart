import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/src/features/settings/domain/entities/language.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/select_language_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Settings row that opens a menu to change the app language.
class SelectLanguageWidget extends ConsumerWidget {
  /// Creates a [SelectLanguageWidget].
  const SelectLanguageWidget({
    required this.title,
    super.key,
  });

  /// Row title.
  final String title;

  void _showLanguageMenu(BuildContext context, WidgetRef ref) {
    final button = context.findRenderObject()! as RenderBox;
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

    unawaited(
      showMenu<Language>(
        context: context,
        position: position,
        items: List.generate(
          Language.all.length,
          (index) {
            final language = Language.all[index];

            return PopupMenuItem(
              onTap: () {
                ref
                    .read(selectLanguageViewModelProvider.notifier)
                    .selectLanguage(language.code);
              },
              value: language,
              child: Text(
                language.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          },
        ),
        elevation: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = Theme.of(context).colorScheme.primary;
    final selectedLanguage = ref.watch(selectLanguageViewModelProvider);

    return ListTileItemWidget(
      onTap: () {
        _showLanguageMenu(context, ref);
      },
      icon: Icons.language,
      title: title,
      trailingWidgets: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              selectedLanguage.name,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: textColor),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: textColor,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/features/settings/domain/entities/language_entity.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/select_language_view_model_provider.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectLanguageWidget extends ConsumerWidget {
  const SelectLanguageWidget({
    super.key,
    required this.title,
  });

  final String title;

  void _showLanguageMenu(BuildContext context, WidgetRef ref) {
    final button = context.findRenderObject() as RenderBox;
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

    showMenu(
      context: context,
      position: position,
      items: List.generate(
        LanguageEntity.all.length,
        (index) {
          final language = LanguageEntity.all[index];

          return PopupMenuItem(
            onTap: () {
              ref
                  .read(selectLanguageViewModelProvider.notifier)
                  .selectLanguage(language.code);
            },
            value: language,
            child: Text(
              language.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14.0,
              ),
            ),
          );
        },
      ),
      elevation: 8.0,
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
              style: TextStyle(
                color: textColor,
                fontSize: 14.0,
              ),
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

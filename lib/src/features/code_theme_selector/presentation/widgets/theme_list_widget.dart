import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/theme_type_enum.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/widgets/theme_card_widget.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

/// Scrollable list of [ThemeCardWidget]s for a set of themes.
class ThemeListWidget extends StatelessWidget {
  /// Creates a [ThemeListWidget].
  const ThemeListWidget({
    required this.themes,
    required this.themeType,
    required this.selectedSchema,
    required this.onThemeSelected,
    required this.previewCode,
    super.key,
  });

  /// Themes to list as `(name, schema)` pairs.
  final List<(String, SyntaxColorSchema)> themes;

  /// Whether these are light or dark themes.
  final ThemeType themeType;

  /// Schema currently selected.
  final SyntaxColorSchema selectedSchema;

  /// Called with the chosen theme's name and schema.
  final void Function(
    String name,
    SyntaxColorSchema schema,
  ) onThemeSelected;

  /// Code snippet shown in each card's preview.
  final String previewCode;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 20,
        right: 16,
        bottom: 36,
        left: 16,
      ),
      itemCount: themes.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final (name, schema) = themes[index];

        return ThemeCardWidget(
          themeName: name,
          themeSchema: schema,
          themeType: themeType,
          isSelected: selectedSchema == schema,
          previewCode: previewCode,
          onTap: () {
            onThemeSelected(name, schema);
          },
        );
      },
    );
  }
}

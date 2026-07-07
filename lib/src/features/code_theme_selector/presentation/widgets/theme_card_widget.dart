import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/theme_type_enum.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

typedef _CardColors = ({
  Color background,
  Color border,
  Color check,
  Color header,
  Color selectedBorder,
  Color separator,
  Color text,
});

final _CardColors _lightCardColors = (
  header: const Color(0xFFF5F5F5),
  background: Colors.white,
  text: const Color(0xFF333333),
  border: Colors.grey.shade200,
  selectedBorder: Colors.grey.shade200.withAlpha(200),
  separator: const Color(0xFFE0E0E0),
  check: Colors.black,
);

final _CardColors _darkCardColors = (
  header: const Color(0xFF2A2D35),
  background: const Color(0xFF1F2228),
  text: const Color(0xFFF0F0F0),
  border: Colors.grey.shade800,
  selectedBorder: Colors.grey.shade800.withAlpha(180),
  separator: const Color(0xFF1A1C21),
  check: Colors.white,
);

/// Card previewing a syntax theme, with a selected indicator.
class ThemeCardWidget extends StatelessWidget {
  /// Creates a [ThemeCardWidget].
  const ThemeCardWidget({
    required this.themeName,
    required this.themeSchema,
    required this.themeType,
    required this.isSelected,
    required this.previewCode,
    required this.onTap,
    super.key,
  });

  /// Display name of the theme.
  final String themeName;

  /// Syntax color scheme previewed by this card.
  final SyntaxColorSchema themeSchema;

  /// Whether this is a light or dark theme.
  final ThemeType themeType;

  /// Whether this theme is currently selected.
  final bool isSelected;

  /// Code snippet shown in the preview.
  final String previewCode;

  /// Called when the card is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isPreviewDark = themeType == ThemeType.dark;
    final cardColors = isPreviewDark ? _darkCardColors : _lightCardColors;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 250,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? cardColors.selectedBorder : cardColors.border,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: isSelected
                  ? Colors.blue.shade500.withAlpha(80)
                  : Colors.black.withAlpha(25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: cardColors.header,
                border: Border(
                  bottom: BorderSide(
                    color: cardColors.separator,
                  ),
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            themeName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: cardColors.text,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: isSelected
                        ? Icon(
                            key: const ValueKey('selected'),
                            Icons.check_circle_rounded,
                            color: Colors.blue.shade400,
                          )
                        : const SizedBox(
                            key: ValueKey('unselected'),
                            width: 24,
                          ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: cardColors.background,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              child: AbsorbPointer(
                child: SyntaxHighlighter(
                  code: previewCode,
                  isDarkMode: isPreviewDark,
                  fontSize: 13,
                  showLineNumbers: false,
                  lightColorSchema: themeSchema,
                  darkColorSchema: themeSchema,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

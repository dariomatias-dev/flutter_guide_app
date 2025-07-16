import 'package:flutter/material.dart';

class _Highlighter {
  final SyntaxTheme theme;

  _Highlighter(this.theme);

  TextStyle getStyleForToken(SyntaxToken token) {
    switch (token.type) {
      case TokenType.bracket:
        final level = token.level % 3;
        if (level == 0) return theme.bracket1Style;
        if (level == 1) return theme.bracket2Style;
        return theme.bracket3Style;
      case TokenType.keyword:
        return theme.keywordStyle;
      case TokenType.specialKeyword:
        return theme.specialKeywordStyle;
      case TokenType.storageModifier:
        return theme.storageModifierStyle;
      case TokenType.type:
        return theme.typeStyle;
      case TokenType.function:
        return theme.functionStyle;
      case TokenType.comment:
        return theme.commentStyle;
      case TokenType.string:
        return theme.stringStyle;
      case TokenType.number:
        return theme.numberStyle;
      case TokenType.literal:
        return theme.literalStyle;
      case TokenType.variable:
        return theme.variableStyle;
      case TokenType.punctuation:
      case TokenType.identifier:
      case TokenType.newline:
        return theme.baseStyle;
    }
  }

  List<SyntaxToken> tokenize(String source) {
    if (!source.endsWith('\n')) {
      source += '\n';
    }

    final tokens = <SyntaxToken>[];
    final bracketStack = <String>[];
    int currentIndex = 0;

    final Map<Pattern, TokenType> patterns = {
      RegExp(r'\b(import|const|void)\b'): TokenType.specialKeyword,
      RegExp(r'\b(@override|return)\b'): TokenType.storageModifier,
      RegExp(r'\b(extends|class|final|var|new|this|super|if|else|for|while|do|switch|case|default|break|continue|as|is|in|throw|try|catch|finally|async|await|yield|export|part|of|library|with|enum|assert)\b'):
          TokenType.keyword,
      RegExp(r'\b(_?[A-Z][a-zA-Z0-9]*|int|double|String|bool)\b'):
          TokenType.type,
      RegExp(r'\b(setState|build|main|runApp|createState)\b'):
          TokenType.function,
      RegExp(r'\b(true|false|null)\b'): TokenType.literal,
      RegExp(r'//[^\n]*'): TokenType.comment,
      RegExp(r"/\*[\s\S]*?\*/"): TokenType.comment,
      RegExp(r"'.*?'"): TokenType.string,
      RegExp(r'".*?"'): TokenType.string,
      RegExp(r'\b\d+(\.\d+)?\b'): TokenType.number,
      RegExp(r'[\.,;]'): TokenType.punctuation,
      RegExp(r'\b[a-zA-Z_][a-zA-Z0-9_]*\b'): TokenType.variable,
    };

    while (currentIndex < source.length) {
      bool matchFound = false;

      if (source[currentIndex] == '\n') {
        tokens.add(
          SyntaxToken(
            TokenType.newline,
            '\n',
          ),
        );
        currentIndex++;
        continue;
      }

      if (RegExp(r'\s').hasMatch(source[currentIndex])) {
        tokens.add(
          SyntaxToken(
            TokenType.identifier,
            source[currentIndex],
          ),
        );
        currentIndex++;
        continue;
      }

      final openBracketMatch = RegExp(r'[\(\[\{]').matchAsPrefix(
        source,
        currentIndex,
      );
      if (openBracketMatch != null) {
        final bracket = openBracketMatch.group(0)!;
        final level = bracketStack.length;
        bracketStack.add(bracket);
        tokens.add(
          SyntaxToken(
            TokenType.bracket,
            bracket,
            level: level,
          ),
        );
        currentIndex += bracket.length;
        continue;
      }

      final closeBracketMatch = RegExp(r'[\)\]\}]').matchAsPrefix(
        source,
        currentIndex,
      );
      if (closeBracketMatch != null) {
        final bracket = closeBracketMatch.group(0)!;
        if (bracketStack.isNotEmpty) bracketStack.removeLast();

        final level = bracketStack.length;
        tokens.add(
          SyntaxToken(
            TokenType.bracket,
            bracket,
            level: level,
          ),
        );
        currentIndex += bracket.length;
        continue;
      }

      for (final entry in patterns.entries) {
        final match = entry.key.matchAsPrefix(source, currentIndex);
        if (match != null) {
          tokens.add(
            SyntaxToken(
              entry.value,
              match.group(0)!,
            ),
          );
          currentIndex += match.group(0)!.length;
          matchFound = true;
          break;
        }
      }

      if (!matchFound) {
        tokens.add(
          SyntaxToken(
            TokenType.identifier,
            source[currentIndex],
          ),
        );
        currentIndex++;
      }
    }

    return tokens;
  }
}

class SyntaxTheme {
  const SyntaxTheme({
    required this.baseStyle,
    required this.lineNumberStyle,
    required this.keywordStyle,
    required this.specialKeywordStyle,
    required this.storageModifierStyle,
    required this.typeStyle,
    required this.functionStyle,
    required this.literalStyle,
    required this.commentStyle,
    required this.punctuationStyle,
    required this.stringStyle,
    required this.numberStyle,
    required this.bracket1Style,
    required this.bracket2Style,
    required this.bracket3Style,
    required this.variableStyle,
  });

  final TextStyle baseStyle;
  final TextStyle lineNumberStyle;
  final TextStyle keywordStyle;
  final TextStyle specialKeywordStyle;
  final TextStyle storageModifierStyle;
  final TextStyle typeStyle;
  final TextStyle functionStyle;
  final TextStyle literalStyle;
  final TextStyle commentStyle;
  final TextStyle punctuationStyle;
  final TextStyle stringStyle;
  final TextStyle numberStyle;
  final TextStyle bracket1Style;
  final TextStyle bracket2Style;
  final TextStyle bracket3Style;
  final TextStyle variableStyle;

  SyntaxTheme copyWithFontSize(double size) {
    return SyntaxTheme(
      baseStyle: baseStyle.copyWith(fontSize: size),
      lineNumberStyle: lineNumberStyle.copyWith(fontSize: size),
      keywordStyle: keywordStyle.copyWith(fontSize: size),
      specialKeywordStyle: specialKeywordStyle.copyWith(fontSize: size),
      storageModifierStyle: storageModifierStyle.copyWith(fontSize: size),
      typeStyle: typeStyle.copyWith(fontSize: size),
      functionStyle: functionStyle.copyWith(fontSize: size),
      literalStyle: literalStyle.copyWith(fontSize: size),
      commentStyle: commentStyle.copyWith(fontSize: size),
      punctuationStyle: punctuationStyle.copyWith(fontSize: size),
      stringStyle: stringStyle.copyWith(fontSize: size),
      numberStyle: numberStyle.copyWith(fontSize: size),
      bracket1Style: bracket1Style.copyWith(fontSize: size),
      bracket2Style: bracket2Style.copyWith(fontSize: size),
      bracket3Style: bracket3Style.copyWith(fontSize: size),
      variableStyle: variableStyle.copyWith(fontSize: size),
    );
  }

  static SyntaxTheme dark() {
    return const SyntaxTheme(
      baseStyle: TextStyle(color: Color(0xFFAEDCFF)),
      lineNumberStyle: TextStyle(color: Color(0xFF9E9E9E)),
      keywordStyle: TextStyle(color: Color(0xFF55AFFF)),
      specialKeywordStyle: TextStyle(color: Color(0xFF569CD6)),
      storageModifierStyle: TextStyle(color: Color(0xFFD670D6)),
      typeStyle: TextStyle(color: Color(0xFF4EE2D0)),
      functionStyle: TextStyle(color: Color(0xFFE6E69A)),
      literalStyle: TextStyle(color: Color(0xFF55AFFF)),
      commentStyle: TextStyle(color: Color(0xFF70B855)),
      punctuationStyle: TextStyle(color: Color(0xFFE0E0E0)),
      stringStyle: TextStyle(color: Color(0xFFDE9378)),
      numberStyle: TextStyle(color: Color(0xFFB9DBA8)),
      bracket1Style: TextStyle(color: Color(0xFFE6E69A)),
      bracket2Style: TextStyle(color: Color(0xFFD670D6)),
      bracket3Style: TextStyle(color: Color(0xFFAEDCFF)),
      variableStyle: TextStyle(color: Color(0xFF9CDCFE)),
    );
  }

  static SyntaxTheme light() {
    return const SyntaxTheme(
      baseStyle: TextStyle(color: Color(0xFF333333)),
      lineNumberStyle: TextStyle(color: Color(0xFF999999)),
      keywordStyle: TextStyle(color: Color(0xFF0000FF)),
      specialKeywordStyle: TextStyle(color: Color(0xFF0000FF)),
      storageModifierStyle: TextStyle(color: Color(0xFFAF00DB)),
      typeStyle: TextStyle(color: Color(0xFF267F99)),
      functionStyle: TextStyle(color: Color(0xFF795E26)),
      literalStyle: TextStyle(color: Color(0xFF0000FF)),
      commentStyle: TextStyle(color: Color(0xFF008000)),
      punctuationStyle: TextStyle(color: Color(0xFF333333)),
      stringStyle: TextStyle(color: Color(0xFFA31515)),
      numberStyle: TextStyle(color: Color(0xFF098658)),
      bracket1Style: TextStyle(color: Color(0xFF795E26)),
      bracket2Style: TextStyle(color: Color(0xFFAF00DB)),
      bracket3Style: TextStyle(color: Color(0xFF333333)),
      variableStyle: TextStyle(color: Color(0xFF001080)),
    );
  }
}

enum TokenType {
  identifier,
  keyword,
  specialKeyword,
  storageModifier,
  type,
  function,
  literal,
  comment,
  punctuation,
  string,
  number,
  bracket,
  newline,
  variable,
}

class SyntaxToken {
  SyntaxToken(
    this.type,
    this.value, {
    this.level = 0,
  });

  final TokenType type;
  final String value;
  final int level;
}

class SyntaxHighlighter extends StatelessWidget {
  const SyntaxHighlighter({
    super.key,
    required this.code,
    this.isDarkMode = false,
    this.fontSize = 14.0,
    this.lineHeight = 1.35,
  });

  final String code;
  final bool isDarkMode;
  final double fontSize;
  final double lineHeight;

  double _calculateLineWidth({
    required double fontSize,
    required double lineHeight,
    required int maxLineNumberDigits,
  }) {
    const characterWidthFactor = 0.6;
    const extraSpacing = 8.0;

    final characterWidth = fontSize * characterWidthFactor;
    final numberWidth = characterWidth * maxLineNumberDigits;

    return numberWidth + extraSpacing;
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = isDarkMode ? SyntaxTheme.dark() : SyntaxTheme.light();
    final theme = baseTheme.copyWithFontSize(fontSize);
    final highlighter = _Highlighter(theme);

    final tokens = highlighter.tokenize(code);
    final lineWidgets = <Widget>[];
    var currentLineSpans = <TextSpan>[];
    var lineNumber = 1;

    final lineCount = '\n'.allMatches(code).length + 1;
    final maxDigits = lineCount.toString().length;

    final lineWidth = _calculateLineWidth(
      fontSize: fontSize,
      lineHeight: lineHeight,
      maxLineNumberDigits: maxDigits,
    );

    for (final token in tokens) {
      if (token.type == TokenType.newline) {
        final lineWidget = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SelectionContainer.disabled(
              child: Container(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                width: lineWidth,
                child: Text(
                  lineNumber.toString(),
                  textAlign: TextAlign.right,
                  style: theme.lineNumberStyle.copyWith(
                    height: lineHeight,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: theme.baseStyle.copyWith(
                    height: lineHeight,
                  ),
                  children: currentLineSpans,
                ),
              ),
            ),
          ],
        );
        lineWidgets.add(lineWidget);

        currentLineSpans = [];
        lineNumber++;
      } else {
        currentLineSpans.add(
          TextSpan(
            text: token.value,
            style: highlighter.getStyleForToken(token),
          ),
        );
      }
    }

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: lineWidgets,
      ),
    );
  }
}

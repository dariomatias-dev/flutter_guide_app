import 'package:flutter/material.dart';

class CodeSyntaxHighlighter {
  final SyntaxTheme theme;

  CodeSyntaxHighlighter(this.theme);

  TextSpan format(String source, {required double lineHeight}) {
    if (!source.endsWith('\n')) {
      source += '\n';
    }

    final spans = <TextSpan>[];
    final tokens = _tokenize(source);
    int lineNumber = 1;

    spans.add(
      TextSpan(
        text: '${lineNumber.toString().padLeft(4)}  ',
        style: theme.lineNumberStyle,
      ),
    );

    for (int i = 0; i < tokens.length; i++) {
      final token = tokens[i];

      if (token.type == _TokenType.newline) {
        lineNumber++;
        spans.add(const TextSpan(text: '\n'));

        if (i < tokens.length - 1) {
          spans.add(
            TextSpan(
              text: '${lineNumber.toString().padLeft(4)}  ',
              style: theme.lineNumberStyle,
            ),
          );
        }
      } else {
        spans.add(
          TextSpan(
            text: token.value,
            style: _getStyle(token),
          ),
        );
      }
    }

    return TextSpan(
      style: TextStyle(height: lineHeight),
      children: spans,
    );
  }

  TextStyle _getStyle(_Token token) {
    switch (token.type) {
      case _TokenType.bracket:
        final level = token.level % 3;
        if (level == 0) return theme.bracket1Style;
        if (level == 1) return theme.bracket2Style;
        return theme.bracket3Style;
      case _TokenType.keyword:
        return theme.keywordStyle;
      case _TokenType.specialKeyword:
        return theme.specialKeywordStyle;
      case _TokenType.storageModifier:
        return theme.storageModifierStyle;
      case _TokenType.type:
        return theme.typeStyle;
      case _TokenType.function:
        return theme.functionStyle;
      case _TokenType.comment:
        return theme.commentStyle;
      case _TokenType.string:
        return theme.stringStyle;
      case _TokenType.number:
        return theme.numberStyle;
      case _TokenType.literal:
        return theme.literalStyle;
      case _TokenType.variable:
        return theme.variableStyle;
      case _TokenType.punctuation:
      case _TokenType.identifier:
      default:
        return theme.baseStyle;
    }
  }

  List<_Token> _tokenize(String source) {
    final tokens = <_Token>[];
    final bracketStack = <String>[];
    int currentIndex = 0;

    final Map<Pattern, _TokenType> patterns = {
      RegExp(r'\b(import|const|void)\b'): _TokenType.specialKeyword,
      RegExp(r'\b(@override|return)\b'): _TokenType.storageModifier,
      RegExp(r'\b(extends|class|final|var|new|this|super|if|else|for|while|do|switch|case|default|break|continue|as|is|in|throw|try|catch|finally|async|await|yield|export|part|of|library|with|enum|assert)\b'):
          _TokenType.keyword,
      RegExp(r'\b(_?[A-Z][a-zA-Z0-9]*|int|double|String|bool)\b'):
          _TokenType.type,
      RegExp(r'\b(setState|build|main|runApp|createState)\b'):
          _TokenType.function,
      RegExp(r'\b(true|false|null)\b'): _TokenType.literal,
      RegExp(r'\b[a-zA-Z_][a-zA-Z0-9_]*\b'): _TokenType.variable,
      RegExp(r'//[^\n]*'): _TokenType.comment,
      RegExp(r"/\*[\s\S]*?\*/"): _TokenType.comment,
      RegExp(r"'.*?'"): _TokenType.string,
      RegExp(r'".*?"'): _TokenType.string,
      RegExp(r'\b\d+(\.\d+)?\b'): _TokenType.number,
      RegExp(r'[\.,;]'): _TokenType.punctuation,
    };

    while (currentIndex < source.length) {
      _Token? matchedToken;

      if (source[currentIndex] == '\n') {
        tokens.add(_Token(_TokenType.newline, '\n'));
        currentIndex++;
        continue;
      }

      if (RegExp(r'\s').hasMatch(source[currentIndex])) {
        tokens.add(_Token(_TokenType.identifier, source[currentIndex]));
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
        tokens.add(_Token(_TokenType.bracket, bracket, level: level));
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
        tokens.add(_Token(_TokenType.bracket, bracket, level: level));
        currentIndex += bracket.length;
        continue;
      }

      for (final entry in patterns.entries) {
        final match = entry.key.matchAsPrefix(source, currentIndex);
        if (match != null) {
          matchedToken = _Token(entry.value, match.group(0)!);
          break;
        }
      }

      if (matchedToken != null) {
        tokens.add(matchedToken);
        currentIndex += matchedToken.value.length;
      } else {
        tokens.add(_Token(_TokenType.identifier, source[currentIndex]));
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

enum _TokenType {
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

class _Token {
  _Token(
    this.type,
    this.value, {
    this.level = 0,
  });

  final _TokenType type;
  final String value;
  final int level;
}

class CodeDisplay extends StatelessWidget {
  const CodeDisplay({
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

  @override
  Widget build(BuildContext context) {
    final baseTheme = isDarkMode ? SyntaxTheme.dark() : SyntaxTheme.light();
    final theme = baseTheme.copyWithFontSize(fontSize);
    final highlighter = CodeSyntaxHighlighter(theme);

    return Text.rich(
      highlighter.format(
        code,
        lineHeight: lineHeight,
      ),
    );
  }
}

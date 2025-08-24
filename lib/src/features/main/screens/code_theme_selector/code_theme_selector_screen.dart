import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/widgets/default_tab_bar_widget.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';

const sampleCode = '''
import 'package:flutter/material.dart';

void main() => runApp(const CounterApp());

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterPage(),
    );
  }
}
''';

enum ThemeType { light, dark }

const _lightCardColors = (
  header: Color(0xFFF5F5F5),
  background: Colors.white,
  text: Color(0xFF333333),
  border: Color(0xFFE0E0E0),
  separator: Color(0xFFE0E0E0),
  check: Colors.black,
);

const _darkCardColors = (
  header: Color(0xFF2A2D35),
  background: Color(0xFF1F2228),
  text: Color(0xFFF0F0F0),
  border: Color(0xFF3A3D46),
  separator: Color(0xFF1A1C21),
  check: Colors.white,
);

class CodeThemeSelectorScreen extends StatefulWidget {
  const CodeThemeSelectorScreen({super.key});

  @override
  State<CodeThemeSelectorScreen> createState() =>
      _CodeThemeSelectorScreenState();
}

class _CodeThemeSelectorScreenState extends State<CodeThemeSelectorScreen>
    with SingleTickerProviderStateMixin {
  late SyntaxColorSchema _selectedSchema;
  late final TabController _tabController;

  final _lightThemes = <(String, SyntaxColorSchema)>[
    ('A11y Light', SyntaxThemes.a11yLight),
    ('Android Studio Light', SyntaxThemes.androidstudioLight),
    ('Atom One Light', SyntaxThemes.atomOneLight),
    ('GitHub Light', SyntaxThemes.githubLight),
    ('Solarized Light', SyntaxThemes.solarizedLight),
    ('StackOverflow Light', SyntaxThemes.stackoverflowLight),
    ('VS Code Light', SyntaxThemes.vsCodeLight),
  ];

  final _darkThemes = <(String, SyntaxColorSchema)>[
    ('A11y Dark', SyntaxThemes.a11yDark),
    ('Android Studio Dark', SyntaxThemes.androidstudioDark),
    ('Atom One Dark', SyntaxThemes.atomOneDark),
    ('Cobalt2', SyntaxThemes.cobalt2),
    ('Dark High Contrast', SyntaxThemes.darkHighContrast),
    ('Dracula', SyntaxThemes.dracula),
    ('GitHub Dark', SyntaxThemes.githubDark),
    ('Material Oceanic', SyntaxThemes.materialOceanic),
    ('Monokai', SyntaxThemes.monokai),
    ('Night Owl', SyntaxThemes.nightOwl),
    ('Nord', SyntaxThemes.nord),
    ('One Dark Pro', SyntaxThemes.oneDarkPro),
    ('Panda Syntax', SyntaxThemes.pandaSyntax),
    ('Solarized Dark', SyntaxThemes.solarizedDark),
    ('StackOverflow Dark', SyntaxThemes.stackoverflowDark),
    ('Synthwave 84', SyntaxThemes.synthwave84),
    ('VS Code Dark', SyntaxThemes.vsCodeDark),
    ('Xcode Dark', SyntaxThemes.xcodeDark),
  ];

  String get _previewCode => sampleCode;

  void _onThemeSelected(SyntaxColorSchema schema) {
    setState(() {
      _selectedSchema = schema;
    });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _selectedSchema = ThemeController.instance.isDark
        ? SyntaxThemes.vsCodeDark
        : SyntaxThemes.vsCodeLight;
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBarWidget(
        title: const Text('Select Code Theme'),
        bottom: DefaultTabBarWidget(
          onTap: (value) {},
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Light',
            ),
            Tab(
              text: 'Dark',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _ThemeList(
            themes: _lightThemes,
            themeType: ThemeType.light,
            selectedSchema: _selectedSchema,
            onThemeSelected: _onThemeSelected,
            previewCode: _previewCode,
          ),
          _ThemeList(
            themes: _darkThemes,
            themeType: ThemeType.dark,
            selectedSchema: _selectedSchema,
            onThemeSelected: _onThemeSelected,
            previewCode: _previewCode,
          ),
        ],
      ),
    );
  }
}

class _ThemeList extends StatelessWidget {
  const _ThemeList({
    required this.themes,
    required this.themeType,
    required this.selectedSchema,
    required this.onThemeSelected,
    required this.previewCode,
  });

  final List<(String, SyntaxColorSchema)> themes;
  final ThemeType themeType;
  final SyntaxColorSchema selectedSchema;
  final ValueChanged<SyntaxColorSchema> onThemeSelected;
  final String previewCode;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 20.0,
        right: 16.0,
        bottom: 36.0,
        left: 16.0,
      ),
      itemCount: themes.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12.0);
      },
      itemBuilder: (context, index) {
        final (name, schema) = themes[index];

        return _ThemeCard(
          themeName: name,
          themeSchema: schema,
          themeType: themeType,
          isSelected: selectedSchema == schema,
          previewCode: previewCode,
          onTap: () => onThemeSelected(schema),
        );
      },
    );
  }
}

class _ThemeCard extends StatelessWidget {
  const _ThemeCard({
    required this.themeName,
    required this.themeSchema,
    required this.themeType,
    required this.isSelected,
    required this.previewCode,
    required this.onTap,
  });

  final String themeName;
  final SyntaxColorSchema themeSchema;
  final ThemeType themeType;
  final bool isSelected;
  final String previewCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPreviewDark = themeType == ThemeType.dark;
    final cardColors = isPreviewDark ? _darkCardColors : _lightCardColors;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 250,
        ),
        curve: Curves.easeInOut,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? colorScheme.primary : cardColors.border,
            width: 2.0,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: isSelected
                  ? colorScheme.primary.withAlpha(80)
                  : Colors.black.withAlpha(25),
              blurRadius: 10.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 50.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: cardColors.header,
                border: Border(
                  bottom: BorderSide(
                    color: cardColors.separator,
                    width: 1.0,
                  ),
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        const _WindowDot(
                          color: Color(0xFFFF5F57),
                        ),
                        const SizedBox(width: 6.0),
                        const _WindowDot(
                          color: Color(0xFFFEBC2E),
                        ),
                        const SizedBox(width: 6.0),
                        const _WindowDot(
                          color: Color(0xFF28C840),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Text(
                            themeName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
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
                            Icons.check_circle_rounded,
                            color: cardColors.check,
                            key: const ValueKey('selected'),
                          )
                        : const SizedBox(
                            width: 24.0,
                            key: ValueKey('unselected'),
                          ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: cardColors.background,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
              ),
              child: AbsorbPointer(
                child: SyntaxHighlighter(
                  code: previewCode,
                  isDarkMode: isPreviewDark,
                  fontSize: 13.0,
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

class _WindowDot extends StatelessWidget {
  const _WindowDot({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.0,
      height: 12.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black.withAlpha(40),
          width: 0.5,
        ),
      ),
    );
  }
}

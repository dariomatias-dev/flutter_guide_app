import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/enums/theme_type_enum.dart';

import 'package:flutter_guide/src/features/code_theme_selector/widgets/theme_list_widget.dart';

import 'package:flutter_guide/src/shared/utils/code_theme_controller.dart';
import 'package:flutter_guide/src/shared/widgets/default_tab_bar_widget.dart';
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

class CodeThemeSelectorScreen extends StatefulWidget {
  const CodeThemeSelectorScreen({super.key});

  @override
  State<CodeThemeSelectorScreen> createState() =>
      _CodeThemeSelectorScreenState();
}

class _CodeThemeSelectorScreenState extends State<CodeThemeSelectorScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _codeThemeController = CodeThemeController.instance;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    _codeThemeController.addListener(_rebuild);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _codeThemeController.removeListener(_rebuild);

    super.dispose();
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: StandardAppBarWidget(
        title: Text(
          appLocalizations.selectCodeTheme,
        ),
        bottom: DefaultTabBarWidget(
          onTap: (value) {},
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: appLocalizations.light,
            ),
            Tab(
              text: appLocalizations.dark,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ThemeListWidget(
            themes: _codeThemeController.lightThemes,
            themeType: ThemeType.light,
            selectedSchema: _codeThemeController.selectedLightTheme,
            onThemeSelected: (name, schema) {
              _codeThemeController.updateTheme(
                name: name,
                schema: schema,
                isDark: false,
              );
            },
            previewCode: sampleCode,
          ),
          ThemeListWidget(
            themes: _codeThemeController.darkThemes,
            themeType: ThemeType.dark,
            selectedSchema: _codeThemeController.selectedDarkTheme,
            onThemeSelected: (name, schema) {
              _codeThemeController.updateTheme(
                name: name,
                schema: schema,
                isDark: true,
              );
            },
            previewCode: sampleCode,
          ),
        ],
      ),
    );
  }
}

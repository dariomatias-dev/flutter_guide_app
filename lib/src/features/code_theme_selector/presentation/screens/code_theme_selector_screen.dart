import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/enums/theme_type_enum.dart';

import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/providers/code_theme_view_model_provider.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/widgets/theme_list_widget.dart';

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

class CodeThemeSelectorScreen extends ConsumerStatefulWidget {
  const CodeThemeSelectorScreen({super.key});

  @override
  ConsumerState<CodeThemeSelectorScreen> createState() =>
      _CodeThemeSelectorScreenState();
}

class _CodeThemeSelectorScreenState
    extends ConsumerState<CodeThemeSelectorScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final codeTheme = ref.watch(codeThemeViewModelProvider);

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
            themes: CodeTheme.lightThemes,
            themeType: ThemeType.light,
            selectedSchema: codeTheme.selectedLightTheme,
            onThemeSelected: (name, schema) {
              ref.read(codeThemeViewModelProvider.notifier).updateTheme(
                    name: name,
                    schema: schema,
                    isDark: false,
                  );
            },
            previewCode: sampleCode,
          ),
          ThemeListWidget(
            themes: CodeTheme.darkThemes,
            themeType: ThemeType.dark,
            selectedSchema: codeTheme.selectedDarkTheme,
            onThemeSelected: (name, schema) {
              ref.read(codeThemeViewModelProvider.notifier).updateTheme(
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

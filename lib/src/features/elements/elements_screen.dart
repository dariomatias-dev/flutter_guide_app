import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/functions.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/widgets.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/shared/widgets/components/components_screen.dart';
import 'package:flutter_guide/src/shared/widgets/default_tab_bar_widget.dart';

class ElementsScreen extends StatefulWidget {
  const ElementsScreen({super.key});

  @override
  State<ElementsScreen> createState() => _ElementsScreenState();
}

class _ElementsScreenState extends State<ElementsScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          DefaultTabBarWidget(
            onTap: (value) {
              if (value != _tabIndex) {
                setState(() {
                  _tabIndex = value;
                });
              }
            },
            tabs: <Tab>[
              const Tab(
                child: Text('Widgets'),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context)!.functions,
                ),
              ),
            ],
          ),
          Expanded(
            child: ComponentsScreen(
              key: GlobalKey(),
              componentType: _tabIndex == 0
                  ? ComponentType.widget
                  : ComponentType.function,
              components: _tabIndex == 0 ? widgets : functions,
            ),
          ),
        ],
      ),
    );
  }
}

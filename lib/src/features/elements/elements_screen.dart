import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/functions.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/widgets.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/widgets/components/components_screen.dart';
import 'package:flutter_guide/src/shared/widgets/default_tab_bar_widget.dart';

class ElementsScreen extends StatefulWidget {
  const ElementsScreen({super.key});

  @override
  State<ElementsScreen> createState() => _ElementsScreenState();
}

class _ElementsScreenState extends State<ElementsScreen>
    with SingleTickerProviderStateMixin {
  ValueNotifier<int>? _elementsScreenTabIndexNotifier;
  TabController? _tabController;
  VoidCallback? _notifierListener;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_elementsScreenTabIndexNotifier == null) {
      _elementsScreenTabIndexNotifier =
          UserPreferencesInheritedWidget.of(context)!
              .elementsScreenTabIndexNotifier;

      int safeIndex = _elementsScreenTabIndexNotifier!.value;
      if (safeIndex < 0 || safeIndex >= 2) safeIndex = 0;

      _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: safeIndex,
      );

      _notifierListener = () {
        int newIndex = _elementsScreenTabIndexNotifier!.value;
        if (newIndex >= 0 &&
            newIndex < _tabController!.length &&
            _tabController!.index != newIndex) {
          _tabController!.animateTo(newIndex);
        }
      };

      _elementsScreenTabIndexNotifier!.addListener(_notifierListener!);
    }
  }

  @override
  void dispose() {
    _elementsScreenTabIndexNotifier?.removeListener(_notifierListener!);
    _tabController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: <Widget>[
        DefaultTabBarWidget(
          controller: _tabController!,
          onTap: (value) {
            if (value != _elementsScreenTabIndexNotifier!.value) {
              _elementsScreenTabIndexNotifier!.value = value;
            }
          },
          tabs: <Tab>[
            const Tab(
              child: Text(
                'Widgets',
              ),
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
            componentType: _tabController!.index == 0
                ? ComponentType.widget
                : ComponentType.function,
            components: _tabController!.index == 0 ? widgets : functions,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/functions.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/widgets.dart';
import 'package:flutter_guide/src/core/di/elements_screen_tab_index_notifier_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/components_screen.dart';
import 'package:flutter_guide/src/shared/widgets/default_tab_bar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ElementsScreen extends ConsumerStatefulWidget {
  const ElementsScreen({super.key});

  @override
  ConsumerState<ElementsScreen> createState() => _ElementsScreenState();
}

class _ElementsScreenState extends ConsumerState<ElementsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_tabController == null) {
      int safeIndex = ref.read(elementsScreenTabIndexNotifierProvider);
      if (safeIndex < 0 || safeIndex >= 2) safeIndex = 0;

      _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: safeIndex,
      );
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null) {
      return const SizedBox.shrink();
    }

    ref.listen(elementsScreenTabIndexNotifierProvider, (previous, next) {
      if (next >= 0 &&
          next < _tabController!.length &&
          _tabController!.index != next) {
        _tabController!.animateTo(next);
      }
    });

    final tabIndex = ref.watch(elementsScreenTabIndexNotifierProvider);

    return Column(
      children: <Widget>[
        DefaultTabBarWidget(
          controller: _tabController!,
          onTap: (value) {
            ref
                .read(elementsScreenTabIndexNotifierProvider.notifier)
                .setIndex(value);
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
            componentType:
                tabIndex == 0 ? ComponentType.widget : ComponentType.function,
            components: tabIndex == 0 ? widgets : functions,
          ),
        ),
      ],
    );
  }
}

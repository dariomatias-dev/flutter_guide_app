import 'package:flutter/material.dart';

import 'package:flutter_guide/src/providers/component_sample_screen_inherited_widget.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/component_sample_controller.dart';

import 'package:flutter_guide/src/shared/widgets/component_sample/widgets/component_sample_app_bar/component_sample_app_bar_widget.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/widgets/code_tab/code_tab_widget.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/widgets/component_sample_font_size_selector_widget.dart';

class ComponentSampleScreen extends StatefulWidget {
  const ComponentSampleScreen({
    super.key,
    required this.title,
    this.popupMenuItems,
    required this.filePath,
    required this.sample,
  });

  final String title;
  final List<PopupMenuEntry>? popupMenuItems;
  final String filePath;
  final Widget sample;

  @override
  State<ComponentSampleScreen> createState() => _ComponentSampleScreenState();
}

class _ComponentSampleScreenState extends State<ComponentSampleScreen>
    with TickerProviderStateMixin {
  late final ComponentSampleController _controller;

  @override
  void didChangeDependencies() {
    _controller = ComponentSampleController(vsync: this);
    
    super.didChangeDependencies();
  }

  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ComponentSampleScreenInheritedWidget(
      file: widget.filePath,
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: ComponentSampleAppBarWidget(
            title: widget.title,
            popupMenuItems: widget.popupMenuItems,
            currentTabIndexNotifier: _controller.currentTabIndexNotifier,
            tabController: _controller.tabController,
          ),
          body: PageView(
            controller: _controller.pageController,
            onPageChanged: _controller.onPageChanged,
            children: <Widget>[
              AnimatedBuilder(
                animation:
                    UserPreferencesInheritedWidget.of(context)!.themeController,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).brightness == Brightness.light
                        ? ThemeData.light()
                        : ThemeData.dark(),
                    child: widget.sample,
                  );
                },
              ),
              CodeTab(
                fontSizeNotifier: _controller.fontSizeNotifier,
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: ValueListenableBuilder(
            valueListenable: _controller.showFloatingActionsNotifier,
            builder: (context, value, child) {
              if (!value) {
                return const SizedBox.shrink();
              }

              return ValueListenableBuilder(
                valueListenable: _controller.fontSizeNotifier,
                builder: (context, value, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ComponentSampleFontSizeSelectorWidget(
                        action: value < ComponentSampleController.maxFontSize
                            ? () {
                                _controller.fontSizeNotifier.value++;
                              }
                            : null,
                        icon: Icons.add,
                      ),
                      const SizedBox(height: 8.0),
                      ComponentSampleFontSizeSelectorWidget(
                        action: value > ComponentSampleController.minFontSize
                            ? () {
                                _controller.fontSizeNotifier.value--;
                              }
                            : null,
                        icon: Icons.remove,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

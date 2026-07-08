import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/component_sample_screen_inherited_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_controller.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/code_tab/code_tab_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/component_sample_app_bar/component_sample_app_bar_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/component_sample_font_size_selector_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen showing a component's running sample alongside its source code.
class ComponentSampleScreen extends ConsumerStatefulWidget {
  /// Creates a [ComponentSampleScreen].
  const ComponentSampleScreen({
    required this.title,
    required this.filePath,
    required this.componentName,
    required this.sample,
    super.key,
    this.popupMenuItems,
  });

  /// Title shown in the app bar.
  final String title;

  /// Optional extra popup menu entries for the app bar.
  final List<PopupMenuEntry<dynamic>>? popupMenuItems;

  /// Path to the sample's source file.
  final String filePath;

  /// Name of the component being shown.
  final String componentName;

  /// The runnable sample widget.
  final Widget sample;

  @override
  ConsumerState<ComponentSampleScreen> createState() =>
      _ComponentSampleScreenState();
}

class _ComponentSampleScreenState extends ConsumerState<ComponentSampleScreen>
    with TickerProviderStateMixin {
  late final _controller = ComponentSampleController(
    vsync: this,
    filePath: widget.filePath,
  );

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider.notifier).isDarkMode;

    return ComponentSampleScreenInheritedWidget(
      fileName: widget.filePath,
      componentName: widget.componentName,
      child: DefaultTabController(
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
            onPageChanged: (index) =>
                _controller.currentTabIndexNotifier.value = index,
            children: <Widget>[
              Theme(
                data: isDark ? ThemeData.dark() : ThemeData.light(),
                child: widget.sample,
              ),
              CodeTabWidget(
                lineCountNotifier: _controller.lineCountNotifier,
                getChunck: _controller.getChunck,
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
                      const SizedBox(height: 8),
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

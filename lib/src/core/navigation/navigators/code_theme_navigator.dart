import 'package:flutter/widgets.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/screens/code_theme_selector_screen.dart';
import 'package:go_router/go_router.dart';

part 'code_theme_navigator.g.dart';

/// The code syntax theme selector screen.
@TypedGoRoute<CodeThemeRoute>(path: '/code-theme')
class CodeThemeRoute extends GoRouteData with $CodeThemeRoute {
  /// Creates a [CodeThemeRoute].
  const CodeThemeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CodeThemeSelectorScreen();
  }
}

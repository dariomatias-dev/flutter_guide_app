/// URL path patterns for the app's routes.
abstract final class RoutePaths {
  /// Root shell route.
  static const root = '/';

  /// Component detail route, parameterized by type and name.
  static const component = '/component/:type/:name';

  /// Interface catalog route, parameterized by interface type.
  static const catalog = '/catalog/:interfaceType';

  /// Component sample viewer route.
  static const componentSample = '/component-sample';

  /// Saved components route, parameterized by type.
  static const savedComponents = '/saved/:type';

  /// Code syntax theme selector route.
  static const codeTheme = '/code-theme';
}

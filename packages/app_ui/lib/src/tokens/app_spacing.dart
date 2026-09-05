/// Spacing scale used across the app.
///
/// The catalog samples in the main app keep their literal values on purpose:
/// they are read as isolated examples, and a token reference there would
/// teach the wrong thing.
abstract final class AppSpacing {
  /// 2 logical pixels. The bottom bar's own item padding.
  static const xxs = 2.0;

  /// 6 logical pixels.
  static const xs = 6.0;

  /// 8 logical pixels.
  static const sm = 8.0;

  /// 10 logical pixels.
  static const smMd = 10.0;

  /// 12 logical pixels.
  static const md = 12.0;

  /// 16 logical pixels.
  static const lg = 16.0;

  /// 20 logical pixels.
  static const xl = 20.0;

  /// 24 logical pixels.
  static const xxl = 24.0;

  /// 28 logical pixels.
  static const xxxl = 28.0;

  /// 36 logical pixels.
  static const huge = 36.0;
}

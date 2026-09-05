/// Corner radius scale used across the app, outside the catalog samples.
abstract final class AppRadius {
  /// 12 logical pixels.
  static const small = 12.0;

  /// 16 logical pixels.
  static const medium = 16.0;

  /// 20 logical pixels.
  static const large = 20.0;

  /// 24 logical pixels.
  static const extraLarge = 24.0;

  /// 32 logical pixels. Tuned to the floating bottom bar's own height, so
  /// its ends read as fully rounded.
  static const full = 32.0;
}

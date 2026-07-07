/// The category a catalog entry belongs to.
enum ComponentType {
  /// A generic Flutter widget.
  widget,

  /// A Material Design widget.
  material,

  /// A Cupertino (iOS-style) widget.
  cupertino,

  /// A top-level function sample (e.g. `showDialog`).
  function,

  /// A third-party package sample.
  package,

  /// A reusable UI element built for this app.
  elements,

  /// A full example screen / user interface.
  uis,
}

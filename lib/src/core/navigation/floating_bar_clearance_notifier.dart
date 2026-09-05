import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the vertical space the floating bottom navigation bar occupies,
/// including its margin and the system inset beneath it.
///
/// The root navigation shell measures the bar after every layout and writes the
/// result here. A screen that scrolls behind the bar reads this instead of a
/// literal offset, so its content clears the bar under gesture navigation and
/// under the taller 3-button bar alike, and keeps clearing it if the user
/// switches between the two while the app is open.
class FloatingBarClearanceNotifier extends Notifier<double> {
  @override
  double build() => 0;

  /// Updates the measured clearance, when [value] actually changed.
  ///
  /// Called from a post-frame callback on every layout, so the guard is what
  /// keeps an unchanged measurement from scheduling another build.
  void update(double value) {
    if (state != value) {
      state = value;
    }
  }
}

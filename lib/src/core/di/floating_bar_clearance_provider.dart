import 'package:flutter_guide/src/core/navigation/floating_bar_clearance_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the app-wide [FloatingBarClearanceNotifier].
///
/// Starts at 0, before the first frame has measured anything: a screen with
/// no content near the bottom loses nothing by starting with no reserved
/// space.
final floatingBarClearanceProvider =
    NotifierProvider<FloatingBarClearanceNotifier, double>(
      FloatingBarClearanceNotifier.new,
    );

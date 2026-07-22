import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether ad banners should be shown.
///
/// Overridden to `false` for automated screenshot capture, so marketing
/// screenshots don't show ads.
final adsEnabledProvider = Provider<bool>((ref) => true);

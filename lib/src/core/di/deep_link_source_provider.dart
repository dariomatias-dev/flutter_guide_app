import 'package:flutter_guide/src/core/services/app_links_deep_link_source.dart';
import 'package:flutter_guide/src/core/services/deep_link_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Where incoming deep links come from.
///
/// A provider so a test can drive the links itself: the plugin behind the
/// default implementation answers over platform channels that stay silent
/// outside a device.
final deepLinkSourceProvider = Provider<DeepLinkSource>((ref) {
  return AppLinksDeepLinkSource();
});

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/config/app_env_providers.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Displays a Google Mobile Ads banner, with a loading placeholder.
class BannerAdWidget extends ConsumerStatefulWidget {
  /// Creates a [BannerAdWidget].
  const BannerAdWidget({super.key});

  @override
  ConsumerState<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends ConsumerState<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    // A build with no ad unit id shows nothing rather than throwing: the id
    // comes from a .env file that a fresh clone and CI do not carry. The
    // environment is only read once ads are on, so a scope that disables them
    // does not have to provide one.
    final adUnitId = ref.read(adsEnabledProvider)
        ? ref.read(appEnvProvider).bannerAdUnitId
        : null;

    if (adUnitId != null) {
      _bannerAd = BannerAd(
        adUnitId: adUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            if (mounted) {
              setState(() {
                _isLoaded = true;
              });
            }
          },
          onAdFailedToLoad: (ad, error) {
            debugPrint(
              'Ad failed to load: $error',
            );

            unawaited(ad.dispose());
          },
        ),
      );

      unawaited(_bannerAd!.load());
    }

    super.initState();
  }

  @override
  void dispose() {
    unawaited(_bannerAd?.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!ref.watch(adsEnabledProvider) || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    if (!_isLoaded) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(
        ad: _bannerAd!,
      ),
    );
  }
}

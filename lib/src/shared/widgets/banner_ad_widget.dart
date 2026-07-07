import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Displays a Google Mobile Ads banner, with a loading placeholder.
class BannerAdWidget extends StatefulWidget {
  /// Creates a [BannerAdWidget].
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: dotenv.env['BANNER_AD_ID']!,
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

    super.initState();
  }

  @override
  void dispose() {
    unawaited(_bannerAd?.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
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

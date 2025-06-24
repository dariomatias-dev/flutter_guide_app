import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => BannerAdWidgetState();
}

class BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: dotenv.env['BANNER_AD_ID']!,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, err) {
          debugPrint(
            'BannerAd failed to load: $err',
          );

          ad.dispose();
        },
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
      ),
    )..load();
  }

  @override
  void initState() {
    _loadAd();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoaded
          ? SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(
                ad: _bannerAd!,
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}

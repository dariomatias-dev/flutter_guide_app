import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleMobileAdsSample extends StatefulWidget {
  const GoogleMobileAdsSample({super.key});

  @override
  State<GoogleMobileAdsSample> createState() => _GoogleMobileAdsSampleState();
}

class _GoogleMobileAdsSampleState extends State<GoogleMobileAdsSample> {
  BannerAd? _bannerAd;

  bool _isLoaded = false;

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: dotenv.env['BANNER_AD_SAMPLE_ID']!,
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
    );

    _bannerAd?.load();
  }

  @override
  void initState() {
    _loadAd();

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Banner AD',
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(
                      ad: _bannerAd!,
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

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
  bool _isBannerLoaded = false;

  InterstitialAd? _interstitialAd;
  bool _isInterstitialLoaded = false;

  RewardedAd? _rewardedAd;
  bool _isRewardedLoaded = false;

  void _loadBanner() {
    _bannerAd = BannerAd(
      adUnitId: dotenv.env['BANNER_AD_SAMPLE_ID']!,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() => _isBannerLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();

          debugPrint(
            'BannerAd failed to load: $error',
          );
        },
      ),
    )..load();
  }

  void _loadInterstitial() {
    InterstitialAd.load(
      adUnitId: dotenv.env['INTERSTICIAL_AD_SAMPLE_ID']!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoaded = true;
        },
        onAdFailedToLoad: (error) {
          debugPrint('InterstitialAd failed to load: $error');
          _isInterstitialLoaded = false;
        },
      ),
    );
  }

  void _showInterstitial() {
    if (!_isInterstitialLoaded || _interstitialAd == null) {
      debugPrint('InterstitialAd is not ready');
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();

        _interstitialAd = null;
        _isInterstitialLoaded = false;

        _loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();

        _interstitialAd = null;
        _isInterstitialLoaded = false;

        debugPrint(
          'InterstitialAd failed to show: $error',
        );

        _loadInterstitial();
      },
    );

    _interstitialAd!.show();
    _interstitialAd = null;
    _isInterstitialLoaded = false;
  }

  void _loadRewarded() {
    RewardedAd.load(
      adUnitId: dotenv.env['REWARDED_AD_SAMPLE_ID']!,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedLoaded = true;
        },
        onAdFailedToLoad: (error) {
          debugPrint(
            'RewardedAd failed to load: $error',
          );

          _isRewardedLoaded = false;
        },
      ),
    );
  }

  void _showRewarded() {
    if (!_isRewardedLoaded || _rewardedAd == null) {
      debugPrint('RewardedAd is not ready');

      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        _isRewardedLoaded = false;
        _loadRewarded();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();

        _rewardedAd = null;
        _isRewardedLoaded = false;
        debugPrint(
          'RewardedAd failed to show: $error',
        );

        _loadRewarded();
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint(
          'Usuário recebeu recompensa: ${reward.amount} ${reward.type}',
        );
      },
    );

    _rewardedAd = null;
    _isRewardedLoaded = false;
  }

  @override
  void initState() {
    _loadBanner();
    _loadInterstitial();
    _loadRewarded();

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Banner Ad',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12.0),
            if (_isBannerLoaded && _bannerAd != null)
              SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(
                  ad: _bannerAd!,
                ),
              )
            else
              const CircularProgressIndicator(),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _showInterstitial,
              child: const Text(
                'Show Interstitial Ad',
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: _showRewarded,
              child: const Text(
                'Show Rewarded Ad',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

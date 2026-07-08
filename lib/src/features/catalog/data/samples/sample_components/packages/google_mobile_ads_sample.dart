import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMobileAdsSample(),
    ),
  );
}

/// Sample demonstrating `GoogleMobileAdsSample`.
class GoogleMobileAdsSample extends StatefulWidget {
  /// Creates a [GoogleMobileAdsSample].
  const GoogleMobileAdsSample({super.key});

  @override
  State<GoogleMobileAdsSample> createState() => _GoogleMobileAdsSampleState();
}

class _GoogleMobileAdsSampleState extends State<GoogleMobileAdsSample> {
  void _navigateTo(
    Widget screen,
  ) {
    unawaited(
      Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (context) => screen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  return _navigateTo(
                    const BannerAdScreen(),
                  );
                },
                child: const Text(
                  'Banner Ad',
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  return _navigateTo(
                    const InterstitialAdScreen(),
                  );
                },
                child: const Text(
                  'Interstitial Ad',
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  return _navigateTo(
                    const RewardedAdScreen(),
                  );
                },
                child: const Text(
                  'Rewarded Ad',
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  return _navigateTo(
                    const AppOpenAdScreen(),
                  );
                },
                child: const Text(
                  'App Open Ad',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sample demonstrating `BannerAdScreen`.
class BannerAdScreen extends StatefulWidget {
  /// Creates a [BannerAdScreen].
  const BannerAdScreen({super.key});

  @override
  State<BannerAdScreen> createState() => _BannerAdScreenState();
}

class _BannerAdScreenState extends State<BannerAdScreen> {
  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;

  void _loadBanner() {
    _bannerAd = BannerAd(
      adUnitId: dotenv.env['BANNER_AD_SAMPLE_ID']!,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          unawaited(ad.dispose());

          debugPrint(
            'BannerAd failed to load: $error',
          );
        },
      ),
    );

    unawaited(_bannerAd!.load());
  }

  @override
  void initState() {
    _loadBanner();

    super.initState();
  }

  @override
  void dispose() {
    unawaited(_bannerAd?.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Banner Ad',
          ),
        ),
        body: Center(
          child: _isBannerLoaded && _bannerAd != null
              ? SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(
                    ad: _bannerAd!,
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

/// Sample demonstrating `InterstitialAdScreen`.
class InterstitialAdScreen extends StatefulWidget {
  /// Creates a [InterstitialAdScreen].
  const InterstitialAdScreen({super.key});

  @override
  State<InterstitialAdScreen> createState() => _InterstitialAdScreenState();
}

class _InterstitialAdScreenState extends State<InterstitialAdScreen> {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialLoaded = false;

  Future<void> _loadInterstitial() {
    return InterstitialAd.load(
      adUnitId: dotenv.env['INTERSTICIAL_AD_SAMPLE_ID']!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoaded = true;

          _showInterstitial();
        },
        onAdFailedToLoad: (error) {
          debugPrint(
            'InterstitialAd failed to load: $error',
          );

          _isInterstitialLoaded = false;
        },
      ),
    );
  }

  void _showInterstitial() {
    if (!_isInterstitialLoaded || _interstitialAd == null) {
      debugPrint(
        'InterstitialAd is not ready',
      );

      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        unawaited(ad.dispose());

        _interstitialAd = null;
        _isInterstitialLoaded = false;

        Navigator.pop(context);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        unawaited(ad.dispose());

        _interstitialAd = null;
        _isInterstitialLoaded = false;

        debugPrint(
          'InterstitialAd failed to show: $error',
        );

        Navigator.pop(context);
      },
    );

    unawaited(_interstitialAd!.show());
  }

  @override
  void initState() {
    unawaited(_loadInterstitial());

    super.initState();
  }

  @override
  void dispose() {
    unawaited(_interstitialAd?.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Interstitial Ad',
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

/// Sample demonstrating `RewardedAdScreen`.
class RewardedAdScreen extends StatefulWidget {
  /// Creates a [RewardedAdScreen].
  const RewardedAdScreen({super.key});

  @override
  State<RewardedAdScreen> createState() => _RewardedAdScreenState();
}

class _RewardedAdScreenState extends State<RewardedAdScreen> {
  RewardedAd? _rewardedAd;
  bool _isRewardedLoaded = false;

  Future<void> _loadRewarded() {
    return RewardedAd.load(
      adUnitId: dotenv.env['REWARDED_AD_SAMPLE_ID']!,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedLoaded = true;

          _showRewarded();
        },
        onAdFailedToLoad: (error) {
          debugPrint(
            'RewardedAd failed to load: $error',
          );

          _isRewardedLoaded = false;

          Navigator.pop(context);
        },
      ),
    );
  }

  void _showRewarded() {
    if (!_isRewardedLoaded || _rewardedAd == null) {
      debugPrint('RewardedAd is not ready');

      Navigator.pop(context);

      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        unawaited(ad.dispose());

        _rewardedAd = null;
        _isRewardedLoaded = false;

        Navigator.pop(context);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        unawaited(ad.dispose());

        _rewardedAd = null;
        _isRewardedLoaded = false;

        debugPrint(
          'RewardedAd failed to show: $error',
        );

        Navigator.pop(context);
      },
    );

    unawaited(
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          debugPrint(
            'Usuário recebeu recompensa: ${reward.amount} ${reward.type}',
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    unawaited(_loadRewarded());
  }

  @override
  void dispose() {
    unawaited(_rewardedAd?.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Rewarded Ad',
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

/// Sample demonstrating `AppOpenAdScreen`.
class AppOpenAdScreen extends StatefulWidget {
  /// Creates a [AppOpenAdScreen].
  const AppOpenAdScreen({super.key});

  @override
  State<AppOpenAdScreen> createState() => _AppOpenAdScreenState();
}

class _AppOpenAdScreenState extends State<AppOpenAdScreen> {
  AppOpenAd? _appOpenAd;
  bool _isAdShowing = false;

  Future<void> _loadAppOpenAd() {
    return AppOpenAd.load(
      adUnitId: dotenv.env['APP_OPEN_AD_SAMPLE_ID']!,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;

          _showAppOpenAd();
        },
        onAdFailedToLoad: (error) {
          debugPrint(
            'AppOpenAd failed to load: $error',
          );

          _goBack();
        },
      ),
    );
  }

  void _showAppOpenAd() {
    if (_appOpenAd == null || _isAdShowing) {
      _goBack();

      return;
    }

    _isAdShowing = true;

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        unawaited(ad.dispose());

        _goBack();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        unawaited(ad.dispose());

        debugPrint(
          'AppOpenAd failed to show: $error',
        );

        _goBack();
      },
    );

    unawaited(_appOpenAd!.show());
  }

  void _goBack() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    unawaited(_loadAppOpenAd());
  }

  @override
  void dispose() {
    unawaited(_appOpenAd?.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'App Open Ad',
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

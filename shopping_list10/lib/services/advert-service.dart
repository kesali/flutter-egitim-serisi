import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AdvertService {
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService() => _instance;
  MobileAdTargetingInfo _targetingInfo;
  final String _bannerAd = Platform.isAndroid
      ? 'ca-app-pub-1985780481766193/3405314811'
      : 'ca-app-pub-1985780481766193/9671340266';

  AdvertService._internal() {
    _targetingInfo = MobileAdTargetingInfo();
  }

  showBanner() {
    BannerAd banner = BannerAd(
        adUnitId: _bannerAd,
        size: AdSize.smartBanner,
        targetingInfo: _targetingInfo);

    banner
      ..load()
      ..show(anchorOffset: 50);

    banner.dispose();
  }

  showIntersitial() {
    InterstitialAd interstitialAd = InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId, targetingInfo: _targetingInfo);

    interstitialAd
      ..load()
      ..show();

    interstitialAd.dispose();
  }
}

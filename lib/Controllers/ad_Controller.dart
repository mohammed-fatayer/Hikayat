import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

import 'package:hikayat/Controllers/MainController.dart';

class Adhelper extends GetxController {
  bool bannerisready = false;

  bool videoisready = false;

   InterstitialAd? rewardad;
   BannerAd? bannerad;

  @override
  void onInit() {
    getInterstitialad();
    bannerad = getbanerad();
    super.onInit();
  }

  BannerAd getbanerad() {
    
    bannerad!= null ? bannerad!.dispose() : null;


    return BannerAd(
        size: Get.width <= 468 ? AdSize.banner : AdSize.fullBanner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        // ca-app-pub-3940256099942544/6300978111    test
        // ca-app-pub-6574668057036090/8234869549    real
        listener: BannerAdListener(onAdLoaded: (ad) {
          bannerisready = true;
          bannerad!.load();
          update(['bannerwidget']);
        }, onAdFailedToLoad: (ad, error) {
          // print("faild to load banner ad${error.message}");

          bannerisready = false;
          ad.dispose();
        }),
        request: const AdRequest())
      ..load();
  }

  getInterstitialad() {
    if (Platform.isAndroid) {
      InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        //ca-app-pub-3940256099942544/1033173712     test
        //ca-app-pub-6574668057036090/8762355294     real
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          rewardad = ad;

          videoisready = true;
        }, onAdFailedToLoad: (LoadAdError error) {
          // print("faild to load Interstitial ad${error.message}");

          throw UnsupportedError("faild");
        }),
      );
    } else {
      throw UnsupportedError("not andriod");
    }
  }

  getappopenad() async {
    AppOpenAd? openad;
    if (Platform.isAndroid) {
      await AppOpenAd.load(
          adUnitId: 'ca-app-pub-3940256099942544/3419835294',

          //  ca-app-pub-3940256099942544/3419835294  test
          //

          request: const AdRequest(),
          adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: ((ad) {
            openad = ad;
            openad!.show();
          }), onAdFailedToLoad: (LoadAdError error) {
            // print(error);
          }),
          orientation: AppOpenAd.orientationPortrait);
    } else {
      throw UnsupportedError("not andriod");
    }
  }

  Future showvideo() async {
    rewardad!.show();
    rewardad!.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) async {
      rewardad!.dispose();
      videoisready = false;
      getInterstitialad();
      Future.delayed(const Duration(seconds: 1));
    });
  }
  // static getrewardad() {
  //   if (Platform.isAndroid) {
  //     RewardedAd.load(
  //       adUnitId: "ca-app-pub-3940256099942544/5224354917",
  //       rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
  //         controller.rewardad = ad;
  //       }, onAdFailedToLoad: (LoadAdError error) {
  //         print("faild to load banner ad${error.message}");

  //         throw UnsupportedError("faild");
  //       }),
  //       request: const AdRequest(),
  //     );
  //   } else {
  //     throw UnsupportedError("not andriod");
  //   }
  // }
}

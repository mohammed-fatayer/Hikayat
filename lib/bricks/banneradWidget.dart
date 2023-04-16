import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hikayat/Controllers/ad_Controller.dart';
import 'package:hikayat/main.dart';

class BannerAdwWidget extends StatelessWidget {
  const BannerAdwWidget({super.key});

  @override
  Widget build(BuildContext context) {
    adhelper.bannerisready = false;
   
    adhelper.getbanerad();
    return GetBuilder(
      id: 'bannerwidget',
      builder: (Adhelper adhelper) {
      
      return SizedBox(
          height: 50,
          width: Get.width,
          child: SizedBox(
            child: adhelper.bannerisready
                ? AdWidget(
                    ad: adhelper.bannerad!,
                  )
                : const SizedBox(),
          ));
    });
  }
}

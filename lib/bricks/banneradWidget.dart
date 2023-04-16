import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hikayat/Controllers/ad_Controller.dart';
import 'package:hikayat/main.dart';

class BannerAdwWidget extends StatelessWidget {
  const BannerAdwWidget({super.key});

  @override
  Widget build(BuildContext context) {
  

    adhelper.getbanerad();
    return GetBuilder(
        id: 'bannerwidget',
        builder: (Adhelper adhelper) {
          return Container(
            width: Get.width,
            color:  context.theme.primaryColor,
            child: Container(
              constraints: BoxConstraints.tightFor(
                width: adhelper.bannerad!.size.width.toDouble(),
                height: adhelper.bannerad!.size.height.toDouble(),
              ),
              child: adhelper.bannerisready
                  ? AdWidget(
                      ad: adhelper.bannerad!,
                    )
                  : const SizedBox(),
            ),
          );
        });
  }
}

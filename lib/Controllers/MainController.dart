import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/main.dart';

class MainController extends GetxController {
  RxString fontfamily = 'Amiri'.obs;
  RxInt fontsize = 22.obs;
  DataController dataController = Get.find();
  String? currenttheme = sharedpref!.getString("theme");
  bool showBackgroundImage = true;
  Rx<TextTheme> chaptertexttheme = Rx<TextTheme>(Get.theme.textTheme);
  RxInt activeIndex = 0.obs;
  @override
  void onInit() async {
    chaptertexttheme = changeTextTheme();
    await dataController.fetchCategories();
    await dataController.fetchAllStories();
    super.onInit();
  }

  Rx<TextTheme> changeTextTheme() {
    currenttheme = sharedpref!.getString("theme");
    chaptertexttheme.value = Get.theme.textTheme.copyWith(
      bodyLarge: Get.theme.textTheme.bodyLarge!.copyWith(
          color: currenttheme == "light"
              ? const Color.fromARGB(255, 17, 17, 17)
              : Get.theme.colorScheme.onSecondary,
          fontFamily: fontfamily.value,
          fontSize: fontsize.value.toDouble()),
    );

    return chaptertexttheme;
  }

  void changeBackgroundImage() {
    showBackgroundImage = !showBackgroundImage;
    update();
  }
}

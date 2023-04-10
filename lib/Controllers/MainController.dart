import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/main.dart';
import 'package:hikayat/model/DataClass.dart';

class MainController extends GetxController {
  RxString fontfamily = 'Amiri'.obs;
  RxInt fontsize = 22.obs;
  DataController dataController = Get.find();
  String? currenttheme = sharedpref!.getString("theme");
  bool showBackgroundImage = true;
  Rx<TextTheme> chaptertexttheme = Rx<TextTheme>(Get.theme.textTheme);
  RxInt activeIndex = 0.obs;
   List<Story> randomStories = [];
  final MainPageGridSliderScrollController = ScrollController();
  final MainPageLatestSliderScrollController = ScrollController();
  @override
  void onInit() async {
    dataController = Get.find();
       MainPageGridSliderScrollController.addListener(() async{
      if (MainPageGridSliderScrollController.offset ==
          MainPageGridSliderScrollController.position.maxScrollExtent) {
       await dataController.fetchMoreStories();
       
      }
      
    });
       MainPageLatestSliderScrollController.addListener(() async{
      if (MainPageLatestSliderScrollController.offset ==
          MainPageLatestSliderScrollController.position.maxScrollExtent) {
       await dataController.fetchStoriesByDate();
       
      }
      
    });
    chaptertexttheme = changeTextTheme();
    await dataController.fetchMoreStories();
    await dataController.fetchStoriesByDate();
    await dataController.fetchCategories();
 
    super.onInit();
  }
   // dispose the controller
  @override
  void onClose() {
    MainPageGridSliderScrollController.dispose();
    MainPageLatestSliderScrollController.dispose();
    super.onClose();
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

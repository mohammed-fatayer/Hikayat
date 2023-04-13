import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';

class StoryController extends GetxController {
final StoryFilterSliderController = ScrollController();
DataController dataController = Get.find();
String filter = "";

  @override
  void onInit() async {
    StoryFilterSliderController.addListener(() async{
      if (StoryFilterSliderController.offset ==
          StoryFilterSliderController.position.maxScrollExtent) {
       await dataController.fetchStoriesByFilter(filter);
       
       
      }
      
    });
    super.onInit();
  }
}
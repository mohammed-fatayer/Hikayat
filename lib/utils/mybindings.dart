import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


import 'package:get/get.dart';
import 'package:hikayat/Controllers/ChapterController.dart';
import 'package:hikayat/Controllers/GenreController.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/StoryController.dart';


class MyBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut(() =>MainController(),fenix: true);
    // Get.lazyPut(() => MainController(),fenix:true);
    // Get.lazyPut(() => AdminController(),fenix:true);
    // Get.lazyPut(() => GifsController(),fenix:true);
    // Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut(() => GenreController(category: Get.arguments),fenix:true);
    Get.lazyPut(() => StoryController(),fenix:true);
    Get.lazyPut(() => ChapterController(),fenix:true);
    Get.put<DataController>(DataController(), permanent: true);

    // Get.lazyPut(() =>ScrollController());
  }
}

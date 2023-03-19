import 'package:flutter/cupertino.dart';


import 'package:get/get.dart';
import 'package:hikayat/Controllers/MainController.dart';



class MyBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut(() =>MainController(),fenix: true);
    // Get.lazyPut(() => MainController(),fenix:true);
    // Get.lazyPut(() => AdminController(),fenix:true);
    // Get.lazyPut(() => GifsController(),fenix:true);
    // Get.lazyPut(() => Quizcontroller(),fenix:true);
    // Get.put<AuthController>(AuthController(), permanent: true);
    // Get.put<DataController>(DataController(), permanent: true);

    // Get.lazyPut(() =>ScrollController());
  }
}

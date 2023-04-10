

import 'package:get/get.dart';
import 'package:hikayat/Controllers/ChapterController.dart';
import 'package:hikayat/Controllers/GenreController.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/StoryController.dart';


class MyBinding extends Binding {
  @override
  List<Bind> dependencies() {
   return [
       Bind.lazyPut(() =>MainController(),fenix: true),
    // Get.lazyPut(() => MainController(),fenix:true);
    // Get.lazyPut(() => AdminController(),fenix:true);
    // Get.lazyPut(() => GifsController(),fenix:true);
    // Get.put<AuthController>(AuthController(), permanent: true);
    Bind.lazyPut(() => GenreController(category: Get.arguments),fenix:true),
    Bind.lazyPut(() => StoryController(),fenix:true),
    Bind.lazyPut(() => ChapterController(),fenix:true),
    Bind.put<DataController>(DataController(), permanent: true),
   ];
  }


}

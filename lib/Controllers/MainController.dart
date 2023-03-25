import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';

class MainController extends GetxController {
  DataController dataController = Get.find();

  RxInt activeIndex = 0.obs;
  @override
  void onInit() async {
    await dataController.fetchCategories();
    await dataController.fetchAllStories();
    super.onInit();
  }
}

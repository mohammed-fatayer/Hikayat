import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';

class MainController extends GetxController {
  DataController dataController = Get.find();
  @override
  void onInit() async {
    await dataController.fetchCategories();
    super.onInit();
  }
}

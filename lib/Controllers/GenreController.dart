
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/model/DataClass.dart';



class GenreController extends GetxController {
 DataController dataController = Get.find();

 GenreController({required this.category});
  Category category = Get.arguments;
  @override
  void onInit() async {
   
    await dataController.fetchStories(category);
    super.onInit();
  }  
}
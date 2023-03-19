import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hikayat/model/DataClass.dart';

class DataController extends GetxController {
  RxList<Category> categories = <Category>[].obs;

  final docRef = FirebaseFirestore.instance.collection("Categories");

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> fetchCategories() async {
    QuerySnapshot<Map<String, dynamic>> refcatagories = await docRef.get();

    for (var doc in refcatagories.docs) {
      categories.add(Category(
        title: doc.id,
        discribtion: doc["description"],
        imageUrl: doc["image"],
        stories: [],
      ));
    }
  }

  Future fetchStories() async {}
  Future fetchChapter() async {}
}

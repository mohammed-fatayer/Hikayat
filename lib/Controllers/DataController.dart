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

  Future fetchCategories() async {
    QuerySnapshot<Map<String, dynamic>> refcatagories = await docRef.get();
    List<Category> data = [];
    for (var doc in refcatagories.docs) {
      data.add(Category(
        title: doc.id,
        discribtion: doc["description"],
        imageUrl: doc["image"],
        stories: [],
      ));
    }
    categories.value = data;
  }

  Future<List<Story>> fetchStories(Category category) async {
    QuerySnapshot<Map<String, dynamic>> refstories =
        await docRef.doc(category.title).collection("stories").get();
    List<Story> data = [];
    for (var doc in refstories.docs) {
      data.add(Story(
        title: doc.id,
        writer: doc["writer"],
        discription: doc["description"],
        imageUrl: doc["image"],
        chapters: [],
        genre: doc["genre"],
      ));
    }
    return data;
  }

  Future fetchChapter() async {}
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hikayat/model/DataClass.dart';

class DataController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  RxList<Story> stories = <Story>[].obs;
  final docRef = FirebaseFirestore.instance.collection("Categories");

  Future fetchCategories() async {
    QuerySnapshot<Map<String, dynamic>> refcatagories = await docRef.get();
    List<Category> data = [];
    for (var doc in refcatagories.docs) {
      data.add(Category(
          title: doc.id,
          description: doc["description"],
          imageUrl: doc["image"],
          stories: [],
          imageRef: doc["imageRef"],
          timestamp: doc["timestamp"]));
    }
    categories.value = data;
    update();
  }

  Future fetchAllStories() async {
    List<Story> data = [];
    await FirebaseFirestore.instance
        .collectionGroup("stories")
        .get()
        .then((value) {
      for (var story in value.docs) {
        data.add(Story(
          title: story.id,
          writer: story["writer"],
          discription: story["description"],
          imageUrl: story["image"],
          chapters: [],
          genre: story["genre"],
          timestamp: story["timestamp"],
          imageRef: story["imageRef"],
        ));
      }
    }).catchError((e) {
      print(e);
    });

    stories.value = data;

    update();
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
        timestamp: doc["timestamp"],
        imageRef: doc["imageRef"],
      ));
    }
    return data;
  }

  fetchChapters(Story story) async {
    var refchapters = await docRef
        .doc(story.genre)
        .collection("stories")
        .doc(story.title)
        .collection("chapters")
        .get();
    List<Chapter> data = [];
    for (var doc in refchapters.docs) {
      data.add(Chapter(
        title: doc["title"],
        content: doc["content"],
        chapterNumber: doc["chapterNumber"],
        chapterid: doc.id,
        timestamp: doc["timestamp"],
      ));
    }
    return data;
  }
}

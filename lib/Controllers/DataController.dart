import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hikayat/model/DataClass.dart';

class DataController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  RxList<Story> stories = <Story>[].obs;
  RxList<Story> sortedStories = <Story>[].obs;

  RxList<Chapter> chapters = <Chapter>[].obs;
  bool isloading = false;
  bool isloadingmore = true;

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
          docSnapshot: story,
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
        docSnapshot: doc,
      ));
    }
    return data;
  }

  List<Story> sortStoriesByDate() {
    List<Story> list = List<Story>.from(stories);
    if (stories.isNotEmpty) {
      list.sort(
          (a, b) => b.timestamp!.toDate().compareTo(a.timestamp!.toDate()));
      return list;
    } else {
      return list;
    }
  }

  Future fetchChapters(Story story) async {
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
    chapters.value = data;
    update();
    return data;
  }

  List<Story> searchDelegateStories(String query) {
    List<Story> data = [];
    for (var story in stories) {
      if (story.title.toLowerCase().contains(query.toLowerCase())) {
        data.add(story);
      }
    }
    return data;
  }

  Future fetchStoriesByDate() async {
    List<Story> data = [];

    // Get the last document from the current data set
    DocumentSnapshot<Object?>? lastDoc = sortedStories.value.isNotEmpty
        ? sortedStories.value.last.docSnapshot
        : null;

    // Build the query to fetch the next set of documents
    Query query = FirebaseFirestore.instance
        .collectionGroup("stories")
        .orderBy("timestamp",descending: true)
        .limit(5);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    // Fetch the documents and add them to the data list
    await query.get().then((value) {
      if (value.docs.isEmpty) {
        print("no more opjects");
        update();
        isloadingmore = false;
        return;
      }
      if (isloading == true) {
        print("already loading");

        return;
      }
      isloading = true;
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
          docSnapshot: story, // save the document snapshot for pagination
        ));
      }
      
      sortedStories.value += data;
      isloading = false;

      update();
    }).catchError((e) {
      print(e);
    });
  }

  Future fetchMoreStories() async {
    List<Story> data = [];

    // Get the last document from the current data set
    DocumentSnapshot<Object?>? lastDoc =
        stories.value.isNotEmpty ? stories.value.last.docSnapshot : null;

    // Build the query to fetch the next set of documents
    Query query =
        FirebaseFirestore.instance.collectionGroup("stories").limit(5);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    // Fetch the documents and add them to the data list
    await query.get().then((value) {
      if (value.docs.isEmpty) {
        print("no more opjects");
        update();
        isloadingmore = false;
        return;
      }
      if (isloading == true) {
        print("already loading");

        return;
      }
      isloading = true;
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
          docSnapshot: story, // save the document snapshot for pagination
        ));
      }
      stories.value += data;
      isloading = false;

      update();
    }).catchError((e) {
      print(e);
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hikayat/model/DataClass.dart';

class DataController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  RxList<Story> stories = <Story>[].obs;
  RxList<Story> Categoriestories = <Story>[].obs;
  RxList<Story> sortedStories = <Story>[].obs;
  RxList<Story> FilteredStories = <Story>[].obs;
  RxList<Story> searchResultStories = <Story>[].obs;
  RxList<Chapter> chapters = <Chapter>[].obs;
  bool isloading = false;
  bool isloadingmoreForFilterSlider = true;
  bool isloadingmoreForMainDateSlider = true;
  bool isloadingmoreForMainGridSlider = true;

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

  // Future fetchAllStories() async {
  //   List<Story> data = [];
  //   await FirebaseFirestore.instance
  //       .collectionGroup("stories").limit(25)
  //       .get()
  //       .then((value) {
  //     for (var story in value.docs) {
  //       data.add(Story(
  //         title: story["title"],
  //         writer: story["writer"],
  //         description: story["description"],
  //         imageUrl: story["image"],
  //         chapters: [],
  //         genre: story["genre"],
  //         timestamp: story["timestamp"],
  //         imageRef: story["imageRef"],
  //         filter: story["filter"],
  //         docSnapshot: story,
  //       ));
  //     }
  //   }).catchError((e) {
  //     print(e);
  //   });

  //   stories.value = data;

  //   update();
  // }

  Future<List<Story>> fetchStories(Category category) async {
    QuerySnapshot<Map<String, dynamic>> refstories =
        await docRef.doc(category.title).collection("stories").get();
    List<Story> data = [];
    for (var doc in refstories.docs) {
      data.add(Story(
        title: doc["title"],
        writer: doc["writer"],
        description: doc["description"],
        imageUrl: doc["image"],
        chapters: [],
        genre: doc["genre"],
        timestamp: doc["timestamp"],
        imageRef: doc["imageRef"],
        filter: doc["filter"],
        docSnapshot: doc,
      ));
    }
    Categoriestories.value = data;
    update();
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
        .orderBy("timestamp", descending: true)
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

  Future fetchStoriesByFilter(String filter) async {
    List<Story> data = [];

     
 
    // Get the last document from the current data set
    DocumentSnapshot<Object?>? lastDoc = FilteredStories.value.isNotEmpty
        ? FilteredStories.value.last.docSnapshot
        : null;

    Query query = FirebaseFirestore.instance
        .collectionGroup("stories")
        .where("filter", arrayContains: filter);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    await query.limit(5).get().then((value) {
      
        if (value.docs.isEmpty) {
        print("no more opjects");
        update();
        isloadingmoreForFilterSlider = false;
        return;
      }
      if (isloading == true) {
        print("already loading");

        return;
      } 
         isloading = true;
        for (var story in value.docs) {
          data.add(Story(
            title: story["title"],
            writer: story["writer"],
            description: story["description"],
            imageUrl: story["image"],
            chapters: [],
            genre: story["genre"],
            timestamp: story["timestamp"],
            imageRef: story["imageRef"],
            filter: story["filter"],
            docSnapshot: story,
          ));
        }
      
    }).catchError((e) {
      print(e);
    });
    //TODO:add  loading more data circular progress indicator
    if (data.isEmpty) {
      print("No more data");
    }

    isloading = false;
    FilteredStories.value += data;
    update();
  
  }

  Future searchDelegateStories(String query) async {
    List<Story> data = [];
    await FirebaseFirestore.instance
        .collectionGroup("stories")
        .where("title", isGreaterThanOrEqualTo: query)
        .orderBy("title", descending: false)
        .limit(5)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        data.add(Story(
          title: doc["title"],
          writer: doc["writer"],
          description: doc["description"],
          imageUrl: doc["image"],
          chapters: [],
          genre: doc["genre"],
          timestamp: doc["timestamp"],
          imageRef: doc["imageRef"],
          filter: doc["filter"],
          docSnapshot: doc,
        ));
      }
      searchResultStories.value = data;
    }).catchError((e) {
      print(e);
    });
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
        .orderBy("timestamp", descending: true)
        .limit(5);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    // Fetch the documents and add them to the data list
    await query.get().then((value) {
      if (value.docs.isEmpty) {
        print("no more opjects");
        update();
        isloadingmoreForMainDateSlider = false;
        return;
      }
      if (isloading == true) {
        print("already loading");

        return;
      }
      isloading = true;
      for (var story in value.docs) {
        data.add(Story(
          title: story["title"],
          writer: story["writer"],
          description: story["description"],
          imageUrl: story["image"],
          chapters: [],
          genre: story["genre"],
          timestamp: story["timestamp"],
          imageRef: story["imageRef"],
          filter: story["filter"],
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
        isloadingmoreForMainGridSlider = false;
        return;
      }
      if (isloading == true) {
        print("already loading");

        return;
      }
      isloading = true;
      for (var story in value.docs) {
        data.add(Story(
          title: story["title"],
          writer: story["writer"],
          description: story["description"],
          imageUrl: story["image"],
          chapters: [],
          genre: story["genre"],
          timestamp: story["timestamp"],
          imageRef: story["imageRef"],
          filter: story["filter"],
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

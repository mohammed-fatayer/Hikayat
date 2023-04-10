import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String title;
  final String description;
  final String imageUrl;
  final Timestamp? timestamp;
  final String imageRef;
  List<Story> stories = [];

  Category({
    required this.imageRef,
    required this.timestamp,
    required this.stories,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class Story {
  final String title;
  final String writer;
  final String discription;
  final String imageUrl;
  final String genre;
  final String imageRef;
  final Timestamp? timestamp;
  List<Chapter> chapters = [];
    final DocumentSnapshot? docSnapshot;

  Story({
    required this.timestamp,
    required this.writer,
    required this.title,
    required this.discription,
    required this.imageUrl,
    required this.chapters,
    required this.genre,
    required this.imageRef,
    required this.docSnapshot,
  });
}

class Chapter {
  final String title;
  final String content;
  final Timestamp? timestamp;
  final int chapterNumber;
  final String? chapterid;

  Chapter(
      {required this.chapterid,
      required this.timestamp,
      required this.title,
      required this.content,
      required this.chapterNumber});
}

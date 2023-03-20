class Category {
  final String title;
  final String discribtion;
  final String imageUrl;
  List<Story> stories = [];

  Category({
    required this.stories,
    required this.title,
    required this.discribtion,
    required this.imageUrl,
  });
}

class Story {
  final String title;
  final String writer;
  final String discription;
  final String imageUrl;
  final String genre;
  List<Chapter> chapters = [];

  Story(
      {
      required this.writer,
      required this.title,
      required this.discription,
      required this.imageUrl,
      required this.chapters,
      required this.genre});
}

class Chapter {
  final String title;
  final String content;

  Chapter({required this.title, required this.content});
}

class Category {
  final String title;
  final String discribtion;
  final String imageUrl;
  List<Story> stories=[];

  Category({required this.stories,required this.title, required this.discribtion,required this.imageUrl,});
}

class Story {
  final String title;
  final String discription;
  final String imageUrl;
  List<Chapter> chapters=[];

  Story(this.title, this.discription, this.imageUrl);
}
class Chapter {
  final String title;
  final String content;

  Chapter(this.title, this.content);
}

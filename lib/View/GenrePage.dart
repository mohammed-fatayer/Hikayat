import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/GenreController.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GenrePage extends StatelessWidget {
  GenreController controller = Get.find();
  DataController dataController = Get.find();
  final List<Story> stories;
  GenrePage({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("genre page"),
          ),
          body: GetBuilder<GenreController>(builder: (context) {
            return GridView.builder(
              itemCount: stories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                if (stories == []) {
                  return const CircularProgressIndicator();
                } else {
                  return Card(
                    child: InkWell(
                      onTap: () async {
                        var chapters =
                            await dataController.fetchChapters(stories[index]);
                        Get.toNamed("/story", arguments: chapters);
                      },
                      child: SizedBox(  
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: stories[index].imageUrl,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }),
        );
      },
    );
  }
}

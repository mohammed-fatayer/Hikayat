import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GenrePage extends StatelessWidget {
  MainController controller = Get.find();
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
          body: GetBuilder<MainController>(builder: (context) {
              return GridView.builder(
                shrinkWrap: true,
                itemCount: stories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  if (stories == []) {
                    return const CircularProgressIndicator();
                  } else {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          print("works");
                        },
                        child: SizedBox(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: stories[index].imageUrl,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
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

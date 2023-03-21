import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/StoryController.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoryPage extends StatelessWidget {
  StoryController controller = Get.find();
  DataController dataController = Get.find();
  final List<Chapter> chapters;
  StoryPage({super.key, required this.chapters});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("genre page"),
          ),
          body: GetBuilder<StoryController>(builder: (context) {
              return ListView.builder(
                itemCount: chapters.length,
                itemBuilder: (BuildContext context, int index) {
                  if (chapters == []) {
                    return const CircularProgressIndicator();
                  } else {
                    return Card(
                      child: InkWell(
                        onTap: () {
                            Get.toNamed("/chapter",arguments:chapters[index]);
                        },
                        child:  SizedBox(
                          child: ListTile(title: Text(chapters[index].title),)
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

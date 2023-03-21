import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/ChapterController.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/StoryController.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChapterPage extends StatelessWidget {
  ChapterController controller = Get.find();
  DataController dataController = Get.find();
  final Chapter chapter;
  ChapterPage({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title:  Text(chapter.title),
          ),
          body: GetBuilder<ChapterController>(builder: (context) {
            return Column(
              children: [Text(chapter.title),
              Center(child: Text(chapter.content),)],
            );
          }),
        );
      },
    );
  }
}

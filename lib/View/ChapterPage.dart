import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/ChapterController.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/main.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:hikayat/Controllers/MainController.dart';

class ChapterPage extends StatelessWidget {
  ChapterController controller = Get.find();
  DataController dataController = Get.find();
  Chapter? chapter;
  String? storyname;

  ChapterPage({super.key, this.chapter, this.storyname});

 
  @override
  Widget build(BuildContext context) {
   String? currenttheme= sharedpref!.getString("theme");
     TextTheme chaptertexttheme = context.theme.textTheme.copyWith(
      bodyLarge: context.theme.textTheme.bodyLarge!.copyWith(
          color:currenttheme=="light"? Color.fromARGB(255, 17, 17, 17):context.theme.colorScheme.onSecondary,
          fontFamily: "Amiri",
          fontSize: 20));
    chapter = Get.arguments["chapter"];
    storyname = Get.arguments["storyname"];
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: context.theme.primaryColor,
          appBar: AppBar(
            leading:IconButton(
                onPressed: () {
                  Get.back();
                },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Get.theme.colorScheme.secondary,
                  ),),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              storyname!,
              style: context.theme.textTheme.headlineSmall,
            ),
          ),
          body: GetBuilder<ChapterController>(builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    chapter!.title,
                    style: Get.theme.textTheme.headlineSmall,
                  ),
                  Center(
                    child: Text(
                      chapter!.content,
                      style: chaptertexttheme.bodyLarge,
                    ),
                  )
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

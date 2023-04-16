import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/ChapterController.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/firebaseLogEventController.dart';
import 'package:hikayat/bricks/DrawerWidget.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:hikayat/Controllers/MainController.dart';

class ChapterPage extends StatelessWidget {
  ChapterController controller = Get.find();
  DataController dataController = Get.find();
  FirebaseLogEventController firebaseLogEventController = Get.find();
  Chapter? chapter;

  Story? story;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ChapterPage({super.key, this.chapter, this.story});
  DataController datacontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    chapter = Get.arguments["chapter"];
    story = Get.arguments["story"];
    firebaseLogEventController.logEventChapterOpen(chapter!.title,story!.title);
    return Scaffold(
      drawer: DrawerWidget(),
      body: GetBuilder<MainController>(
        builder: (controller) {
          return Container(
            decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(controller.currentBackground),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              key: _scaffoldKey,
              drawer: DrawerWidget(),
              backgroundColor: controller.showBackgroundImage == true
                  ? Colors.transparent
                  : context.theme.primaryColor,
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Get.theme.colorScheme.secondary,
                    ),
                  ),
                ],
                leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Get.theme.colorScheme.secondary,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  story!.title,
                  style: context.theme.textTheme.headlineSmall,
                ),
              ),
              body: GetBuilder<MainController>(builder: (controller) {
                return SingleChildScrollView(
                  child: Obx(() => Column(
                        children: [
                          Text(
                            chapter!.title,
                            style: Get.theme.textTheme.headlineSmall,
                          ),
                          Center(
                            child: Text(
                              chapter!.content,
                              style: controller
                                  .chaptertexttheme.value.bodyLarge!
                                  .copyWith(
                                color: controller.showBackgroundImage == true
                                    ? const Color.fromARGB(255, 17, 17, 17)
                                    : controller.chaptertexttheme.value
                                        .bodyLarge!.color,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //FIXME: fix navigation to next and previous chapter method
                              //tow icon button for next and previous chapter
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    if (chapter!.chapterNumber ==
                                        dataController.chapters.length) {
                                      Get.rawSnackbar(
                                        
                                        message: "This is the last chapter".tr,
                                        backgroundColor: const Color.fromARGB(
                                            255, 63, 63, 63),
                                        duration: const Duration(seconds: 2),
                                      );
                                    } else {
                                      int newchapternumber =
                                          chapter!.chapterNumber + 1;
                                      Chapter newchapter = dataController
                                          .chapters
                                          .firstWhere((element) =>
                                              element.chapterNumber ==
                                              newchapternumber);
                                      Get.back();
                                      Future.delayed(
                                          const Duration(milliseconds: 200),
                                          () {
                                        Get.toNamed("/chapter", arguments: {
                                          "chapter": newchapter,
                                          "story": story,
                                        });
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Get.theme.colorScheme.secondary,
                                  ),
                                ),
                              ),

                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    if (chapter!.chapterNumber <= 1) {
                                      Get.rawSnackbar(
                                        message: "This is the first chapter".tr,
                                        backgroundColor: const Color.fromARGB(
                                            255, 63, 63, 63),
                                        duration: const Duration(seconds: 2),
                                      );
                                    } else {
                                      int newchapternumber =
                                          chapter!.chapterNumber - 1;
                                      Chapter newchapter = dataController
                                          .chapters
                                          .firstWhere((element) =>
                                              element.chapterNumber ==
                                              newchapternumber);
                                      Get.back();
                                      Future.delayed(
                                          const Duration(milliseconds: 200),
                                          () {
                                        Get.toNamed("/chapter", arguments: {
                                          "chapter": newchapter,
                                          "story": story,
                                        });
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Get.theme.colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

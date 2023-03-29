import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/ChapterController.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/bricks/DrawerWidget.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:hikayat/Controllers/MainController.dart';

class ChapterPage extends StatelessWidget {
  ChapterController controller = Get.find();
  DataController dataController = Get.find();
  Chapter? chapter;
  String? storyname;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ChapterPage({super.key, this.chapter, this.storyname});

  @override
  Widget build(BuildContext context) {
    chapter = Get.arguments["chapter"];
    storyname = Get.arguments["storyname"];
    return Scaffold(
      drawer: DrawerWidget(),
      body: GetBuilder<MainController>(
        builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/paper.jpg"),
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
                  storyname!,
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
                                    :controller.chaptertexttheme.value.bodyLarge!.color,
                              ),
                            ),
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

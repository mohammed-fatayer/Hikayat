import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/model/DataClass.dart';

class ChaptersListWidget extends StatelessWidget {
  final Story story;

  ChaptersListWidget({super.key, required this.story});

  DataController dataController = Get.find();
  @override
  Widget build(BuildContext context) {
    dataController.fetchChapters(story);
    return GetBuilder(
        init: dataController,
        builder: (contoller) {
          return Container(
            color: context.theme.primaryColor,
            child: contoller.chapters.isEmpty
                ? Center(
                    child: Padding(

                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text(
                        "Oops! couldn't find any chapters".tr,
                        style: TextStyle(
                            color: Get.theme.textTheme.bodyLarge!.color,
                            fontFamily: "Roboto",
                            fontSize: 25),
                      ),
                    ),
                  )
                : contoller.chapters.isEmpty
                    ? Center(
                        child: Text(
                          "Oops! couldn't find any chapters".tr,
                          style: context.theme.textTheme.bodyLarge,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: contoller.chapters.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                String storyname = story.title;
                                Get.toNamed("/chapter", arguments: {
                                  "chapter": contoller.chapters[index],
                                  "story": story,
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                contoller.chapters[index].title,
                                                style: Get
                                                    .theme.textTheme.bodyMedium,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Divider(
                                      thickness: 2,
                                      color:
                                          context.theme.colorScheme.secondary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          );
        });
  }
}

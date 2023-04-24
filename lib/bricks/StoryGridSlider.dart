import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';

import 'package:hikayat/model/DataClass.dart';

class StoryGridSlide extends StatelessWidget {
  StoryGridSlide({super.key});

  DataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    return GetBuilder<DataController>(
        init: controller,
        builder: (context) {
          List<Story> stories = controller.stories;
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Library".tr,
                        style: theme.textTheme.headlineSmall),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: stories.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        physics: const BouncingScrollPhysics(),
                        itemCount: stories.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (stories.length == index) {
                            if (controller.isloadingmoreForMainGridSlider ==
                                false) {
                              return const Center(child: SizedBox());
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          return Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed("/story",
                                    arguments: stories[index]);
                              },
                              child: Card(
                                color: Get.theme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Get.theme.colorScheme.secondary,
                                      width: 2),
                                ),
                                elevation: 5,
                                child: Hero(
                                  tag: stories[index].title,
                                  child: SizedBox(
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    stories[index].imageUrl,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  "assets/images/loading.gif",
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            stories[index].title,
                                            style: theme.textTheme.bodyLarge,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        });
  }
}

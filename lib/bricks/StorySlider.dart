import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:hikayat/model/DataClass.dart';

class StorySlider extends StatefulWidget {
  const StorySlider({super.key});

  @override
  State<StorySlider> createState() => _StorySliderState();
}

class _StorySliderState extends State<StorySlider> {
  DataController controller = Get.find();
  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    return GetBuilder<DataController>(
        init: controller,
        builder: (context) {
          List<Story> sotredStories = controller.sortedStories;
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Recently Added".tr,
                        style: theme.textTheme.headlineSmall),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: Get.height * 0.2,
                child: sotredStories.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller:
                            mainController.MainPageLatestSliderScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: sotredStories.length + 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == sotredStories.length) {
                            if (controller.isloadingmoreForMainDateSlider ==
                                false) {
                              return const Center(child: SizedBox());
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed("/story",
                                      arguments: sotredStories[index]);
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
                                    tag: sotredStories[index].imageUrl,
                                    child: SizedBox(
                                      width: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: sotredStories[index]
                                                      .imageUrl,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                    "assets/images/loading.gif",
                                                    fit: BoxFit.cover,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              sotredStories[index].title,
                                              style: context
                                                  .theme.textTheme.bodyLarge,
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
                          }
                        }),
              ),
            ],
          );
        });
  }
}

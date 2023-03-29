import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/model/DataClass.dart';

class StorySlider extends StatefulWidget {
  const StorySlider({super.key});

  @override
  State<StorySlider> createState() => _StorySliderState();
}

class _StorySliderState extends State<StorySlider> {
  DataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    return GetBuilder<DataController>(
        init: controller,
        builder: (context) {
          List<Story> sotredStories = controller.sortStoriesByDate();
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
                        physics: const BouncingScrollPhysics(),
                        itemCount: sotredStories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed("/story",
                                    arguments: sotredStories[index]);
                              },
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
                                              imageUrl:
                                                  sotredStories[index].imageUrl,
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
                                          style:
                                              context.theme.textTheme.bodyLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
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

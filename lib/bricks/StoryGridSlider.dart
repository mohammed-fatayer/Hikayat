import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';

class StoryGridSlide extends StatefulWidget {
  const StoryGridSlide({super.key});

  @override
  State<StoryGridSlide> createState() => _StoryGridSlideState();
}

class _StoryGridSlideState extends State<StoryGridSlide> {
  DataController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
        init: controller,
        builder: (context) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Library",
                        style: Get.theme.textTheme.headlineSmall),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: controller.stories.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.stories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Hero(
                                tag: controller.stories[index].title,
                                child: SizedBox(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: controller
                                                  .stories[index].imageUrl,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          controller.stories[index].title,
                                          style: Get.theme.textTheme.bodyLarge,
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

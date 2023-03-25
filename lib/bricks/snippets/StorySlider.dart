import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';

class StorySlider extends StatefulWidget {
  const StorySlider({super.key});

  @override
  State<StorySlider> createState() => _StorySliderState();
}

class _StorySliderState extends State<StorySlider> {
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
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Latest Added Stories",
                        style: Get.theme.textTheme.headlineSmall),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: controller.stories.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.stories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Hero(
                                tag: 'someTag',
                                child: SizedBox(
                                  width: 100,
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

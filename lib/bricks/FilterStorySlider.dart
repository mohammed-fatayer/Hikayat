import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/StoryController.dart';
import 'package:hikayat/Controllers/firebaseLogEventController.dart';
import 'package:hikayat/model/DataClass.dart';

class FilterStorySlider extends StatelessWidget {
  final String filter;
  FilterStorySlider({super.key, required this.filter});

  DataController controller = Get.find();

  StoryController stroryController = Get.find();
  FirebaseLogEventController firebaseLogEventController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.FilteredStories.value = [];
    stroryController.filter = filter;
    firebaseLogEventController.logEventFilterClick(filter);
    controller.fetchStoriesByFilter(filter);

    
    ThemeData theme = context.theme;
    return GetBuilder<DataController>(
        init: controller,
        builder: (context) {
       
          List<Story> filteredstories = controller.FilteredStories.value;
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(filter, style: theme.textTheme.headlineSmall),
                    ),
                  ],
                ),
                SizedBox(
                    width: Get.width * 0.7,
                    height: Get.height * 0.7,
                    child: filteredstories.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            shrinkWrap: true,
                            controller:
                                stroryController.StoryFilterSliderController,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(width: 8.0),
                            itemCount: filteredstories.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == filteredstories.length) {
                                if (controller.isloadingmoreForFilterSlider ==
                                        false ) {
                                  return const Center(child: SizedBox());
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      //FIXME: scufted ti navigate to story
                                      Get.back();
                                      Get.back();
                                      Future.delayed(
                                          const Duration(milliseconds: 200),
                                          () {
                                        Get.toNamed("/story",
                                            arguments: filteredstories[index]);
                                      });
                                    },
                                    child: Hero(
                                      tag: filteredstories[index].imageUrl,
                                      child: SizedBox(
                                        height: 200,
                                        width: 50,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Expanded(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        filteredstories[index]
                                                            .imageUrl,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      "assets/images/loading.gif",
                                                      fit: BoxFit.cover,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                filteredstories[index].title,
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
                                );
                              }
                            })),
              ],
            ),
          );
        });
  }
}

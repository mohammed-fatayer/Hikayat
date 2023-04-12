import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/bricks/FilterRowWidget.dart';
import 'package:hikayat/model/DataClass.dart';

class SearchDelegateResults extends StatelessWidget {
  DataController controller = Get.find();
  List<Story> stories = [];
  final String query;
  SearchDelegateResults({super.key, required this.query});
  
  @override
  Widget build(BuildContext context) {
    
    
    
    return FutureBuilder(
      future: controller.searchDelegateStories(query),
      builder: (context, snapshot) {
        return GetBuilder<DataController>(
          init: controller,
          builder: (controller) {
            stories = controller.searchResultStories.value;
            return Container(
              height: Get.height,
              width: Get.width,
              color: context.theme.primaryColor.withOpacity(0.8),
              child: stories.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: stories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed("/story", arguments: stories[index]);
                            },
                            child: SizedBox(
                              height: 150,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: context.theme.primaryColor,
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  context.theme.colorScheme.secondary)),
                                      height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 118.0, top: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              stories[index].title,
                                              style: Get.theme.textTheme.bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: <Widget>[
                                                  FilterRowWidget(
                                                      story: stories[index]),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 8,
                                    child: SizedBox(
                                      width: 100,
                                      height: 125,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: stories[index].imageUrl,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return Image.asset(
                                                "assets/images/loading.gif",
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            );
          }
        );
      }
    );
  }
}

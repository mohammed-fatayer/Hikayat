import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/model/DataClass.dart';

class SearchDelegateResults extends StatelessWidget {
  DataController controller = Get.find();
  final String query;
   SearchDelegateResults({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    List<Story> stories = controller.searchDelegateStories(query);
    return Container(
      // height: Get.height * 0.8,
      // width: Get.width*0.9,
      color: context.theme.primaryColor.withOpacity(0.8),
      child: stories.isEmpty
          ?  Center(
              child: Image.asset("assets/images/loading.gif",fit: BoxFit.cover,),
            )
          : ListView.builder(
            
              physics: const BouncingScrollPhysics(),
              itemCount: stories.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
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
                                      color: context.theme.colorScheme.secondary)),
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 118.0, top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      stories[index].title,
                                      style: context.theme.textTheme.bodyMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const <Widget>[],
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
                                child:CachedNetworkImage(imageUrl: stories[index].imageUrl,fit: BoxFit.cover,placeholder: (context, url) {
                                  return Image.asset("assets/images/loading.gif",fit: BoxFit.cover,);
                                },)
                              ),
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
}

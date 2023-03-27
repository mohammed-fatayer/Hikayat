import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/ChapterController.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/bricks/ChaptersListWidget.dart';
import 'package:hikayat/model/DataClass.dart';

class StoryPage extends StatelessWidget {
  final Story story = Get.arguments;
  StoryPage({super.key, required});

  DataController dataController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: story.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: ((context, url) {
                          return Center(
                              child: Image.asset('assets/images/loading.gif'));
                        }),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                context.theme.colorScheme.secondary,
                                context.theme.colorScheme.secondary
                                    .withOpacity(0.3),
                                context.theme.colorScheme.secondary
                                    .withOpacity(0.2),
                                context.theme.colorScheme.secondary
                                    .withOpacity(0.1),
                              ],
                              stops: const [
                                0.0,
                                0.25,
                                0.5,
                                0.75
                              ])),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: context.theme.colorScheme.secondary,
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: context.theme.colorScheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: context.theme.primaryColor,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 80.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(60.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          story.title,
                                          style:
                                              context.theme.textTheme.headlineSmall,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'chapters',
                                                style: Get
                                                    .theme.textTheme.bodyLarge,
                                              ),
                                            ),
                                          ],
                                        ),
                                        ChaptersListWidget(
                                          story: story,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 140,
                        child: SizedBox(
                          width: 100,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: FadeInImage(
                              image: NetworkImage(story.imageUrl),
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('assets/images/loading.gif'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/GenreController.dart';
import 'package:hikayat/bricks/ParticularGenreStories.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GenrePage extends StatelessWidget {
  GenrePage({super.key});
  DataController dataController = Get.find<DataController>();
  GenreController controller = Get.find<GenreController>();
  Category category = Get.arguments;

  @override
  Widget build(BuildContext context) {
    List<Story> stories = dataController.stories;

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
                        imageUrl: category.imageUrl,
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
                                Get.theme.colorScheme.secondary,
                                Get.theme.colorScheme.secondary
                                    .withOpacity(0.3),
                                Get.theme.colorScheme.secondary
                                    .withOpacity(0.2),
                                Get.theme.colorScheme.secondary
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
                  color: Get.theme.colorScheme.secondary,
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
                    color: Get.theme.colorScheme.secondary,
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
                          padding: const EdgeInsets.fromLTRB(16, 75, 16, 16),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Get.theme.primaryColor,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          category.title,
                                          style:
                                              Get.theme.textTheme.headlineSmall,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(
                                      
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: Get.height * 0.1,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Overview',
                                                style: Get
                                                    .theme.textTheme.bodyLarge,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            category.description,
                                            style:
                                                Get.theme.textTheme.bodySmall,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.1,
                                        ),  
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Stories',
                                                style: Get
                                                    .theme.textTheme.bodyLarge,
                                              ),
                                            ),
                                          ],
                                        ),
                                        ParticularGenreStories()
                           
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
                        left: 40,
                        child: Hero(
                          tag: category.title,
                          child: SizedBox(
                            width: 100,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage(
                                image: NetworkImage(category.imageUrl),
                                fit: BoxFit.cover,
                                placeholder: const AssetImage(
                                    'assets/images/loading.gif'),
                              ),
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

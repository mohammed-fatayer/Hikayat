import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';

class DiscoverGenres extends StatelessWidget {
  const DiscoverGenres({super.key});

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find();

    return GetBuilder<DataController>(
        init: dataController,
        builder: (controller) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Discover'.tr,
                        style: context.theme.textTheme.headlineSmall),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: Get.height * 0.3,
                child: dataController.categories.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CarouselSlider.builder(
                        options: CarouselOptions(
                          disableCenter: true,
                          viewportFraction: 0.8,
                          autoPlay: true,
                          autoPlayAnimationDuration: const Duration(seconds: 3),
                          enlargeCenterPage: true,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, pageViewIndex) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed('/genre',
                                  arguments: dataController.categories[index]);
                            },
                            child: Hero(
                              tag: controller.categories[index].title,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      dataController.categories[index].imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Image.asset("assets/images/loading.gif"),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: dataController.categories.length,
                      ),
              ),
            ],
          );
        });
  }
}

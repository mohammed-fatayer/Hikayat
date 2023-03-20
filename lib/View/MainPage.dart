import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MainPage extends StatelessWidget {
  MainController controller = Get.find();
  DataController dataController = Get.find();
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Main Page"),
          ),
          drawer: Drawer(),
          body: GetBuilder<MainController>(builder: (context) {
            return Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                itemCount: dataController.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  if (dataController.categories == []) {
                    return const CircularProgressIndicator();
                  } else {
                    return Card(
                      child: InkWell(
                        onTap: ()async {
                          var stories=await dataController.fetchStories(dataController.categories[index]);
                          Get.toNamed("/genre",arguments:stories);
                        },
                        child: SizedBox(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: dataController.categories[index].imageUrl,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
            });
          }),
        );
      },
    );
  }
}
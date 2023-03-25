import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:hikayat/bricks/snippets/DiscoverGenres.dart';
import 'package:hikayat/bricks/snippets/StoryGridSlider.dart';
import 'package:hikayat/bricks/snippets/StorySlider.dart';

class MainPage extends StatelessWidget {
  MainController controller = Get.find();
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Get.theme.colorScheme.secondary,
          ),
          onPressed: () {
            // _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          'Matinee',
          style: Get.theme.textTheme.headlineSmall,
        ),
        backgroundColor: Get.theme.primaryColor,
        actions: <Widget>[
          IconButton(
            color: Get.theme.colorScheme.secondary,
            icon: const Icon(Icons.search),
            onPressed: () async {},
          )
        ],
      ),
      // drawer: Drawer(
      //   child: SettingsPage(),
      // ),
      body: GetBuilder<MainController>(
        init: controller,
        builder: (controller) {
          return Container(
            color: Get.theme.primaryColor,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: const <Widget>[
                DiscoverGenres(),
                StorySlider(),
                StoryGridSlide(),
                // StorySlider(),
                // StorySlider(
                //   themeData: state.themeData,
                //   title: 'Upcoming Movies',
                //   api: Endpoints.upcomingMoviesUrl(1),
                //   genres: _genres,
                // ),
                // StorySlider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

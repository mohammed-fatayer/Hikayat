import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:hikayat/Controllers/ad_Controller.dart';
import 'package:hikayat/Controllers/firebaseLogEventController.dart';
import 'package:hikayat/bricks/DiscoverGenres.dart';
import 'package:hikayat/bricks/DrawerWidget.dart';
import 'package:hikayat/bricks/StoryGridSlider.dart';
import 'package:hikayat/bricks/StorySlider.dart';
import 'package:hikayat/searchDelegate/searchStories.dart';

class MainPage extends StatelessWidget {
  MainController controller = Get.find();
  FirebaseLogEventController firebaseLogEventController = Get.find();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: context.theme.primaryColor,
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: context.theme.colorScheme.secondary,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          'rewiat'.tr,
          style: context.theme.textTheme.headlineSmall,
        ),
        backgroundColor: context.theme.primaryColor,
        actions: <Widget>[
          IconButton(
            color: context.theme.colorScheme.secondary,
            icon: const Icon(Icons.search),
            onPressed: () async {
              // show search delegate in getx
              firebaseLogEventController.logEventSearchClick();
              await showSearch(context: context, delegate: SearchStories());
            },
          )
        ],
      ),
      // drawer: Drawer(
      //   child: SettingsPage(),
      // ),
      body: GetBuilder<MainController>(
        init: controller,
        builder: (controller) {
          return Stack(
            children: [
              ListView(
                controller: controller.MainPageGridSliderScrollController,
                physics: const ClampingScrollPhysics(),
                children: <Widget>[
                  const DiscoverGenres(),
                  const StorySlider(),
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
            ],
          );
        },
      ),
    );
  }
}

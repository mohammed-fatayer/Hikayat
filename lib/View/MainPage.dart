import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:hikayat/Controllers/MainController.dart';

class MainPage extends StatelessWidget {
  MainController controller = Get.find();
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
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return const Card(child: Text("hi"),);
            },
          ),
        );
      },
    );
  }
}

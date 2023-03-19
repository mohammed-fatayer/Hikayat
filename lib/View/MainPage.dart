import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          body: Center(
            child: Text("Main Page"),
          ),
        );
      },
    );
  }
}

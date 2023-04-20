import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:hikayat/Controllers/firebaseLogEventController.dart';
import 'package:hikayat/main.dart';
import 'package:hikayat/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  final MainController controller = Get.find();
  FirebaseLogEventController firebaseLogEventController = Get.find();

  final String _fontFamily = 'Amiri';
  final List<Color> colors = [
    Colors.white,
    const Color(0xff242248),
    Colors.black
  ];
  final List<Color> borders = [Colors.black, Colors.white, Colors.white];
  final List<String> themes = ['Light', 'Dark', 'Amoled'];

  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: controller,
        builder: (controller) {
          return Container(
            color: context.theme.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  child: SizedBox(
                                    height: Get.height * 0.05,
                                    child: InkWell(
                                      onTap: () {
                                        firebaseLogEventController
                                            .logEventAboutUsClick();
                                        Get.defaultDialog(
                                          title: "About us".tr,
                                          titleStyle: context
                                              .theme.textTheme.bodyMedium,
                                          content: Text(
                                            "contact us message".tr,
                                            style: context
                                                .theme.textTheme.bodyMedium,
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "About us".tr,
                                          ),
                                          const SizedBox(width: 10),
                                          const Icon(Icons.info),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: SizedBox(
                                    height: Get.height * 0.05,
                                    child: InkWell(
                                      onTap: () {
                                        firebaseLogEventController
                                            .logEventEmailUsClick();
                                        //TODO: dont forget to add contack email
                                        final Uri url = Uri(
                                          scheme: 'mailto',
                                          path: 'support@example.com',
                                          query:
                                              'subject=Contact Us&body=Hello,',
                                        );
                                        launchUrl(url);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("contact us".tr),
                                          const SizedBox(width: 10),
                                          const Icon(Icons.mail)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: SizedBox(
                                    height: Get.height * 0.05,
                                    child: InkWell(
                                      //TODO: dont forget to add telegram channel link
                                      onTap: () {
                                        firebaseLogEventController
                                            .logEventTelegramClick();
                                        Uri url = Uri.parse(
                                            "https://t.me/s/pathto_flutter");
                                        launchUrl(url);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Telegram".tr),
                                          const SizedBox(width: 10),
                                          const Icon(Icons.send),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: SizedBox(
                                    height: Get.height * 0.05,
                                    child: InkWell(
                                      //TODO: dont forget to add play store link
                                      onTap: () {
                                        firebaseLogEventController
                                            .logEventRateUsClick();
                                        // Launch app store to rate app here
                                        Uri url = Uri.parse(
                                            "https://play.google.com/store/apps/details?id=com.mojang.minecraftpe");
                                        launchUrl(url);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Rate us".tr),
                                          const SizedBox(width: 10),
                                          const Icon(Icons.star),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            Text("Font family".tr,
                                style: controller
                                    .chaptertexttheme.value.bodyLarge),
                            const Divider(),
                            DropdownButton<String>(
                                dropdownColor: context.theme.primaryColor,
                                value: controller.fontfamily.value,
                                style: controller
                                    .chaptertexttheme.value.bodyLarge
                                    ?.copyWith(fontSize: 18),
                                items: controller.fonts
                                    .map(
                                      (font) => DropdownMenuItem<String>(
                                          value: font,
                                          child: Text(
                                            font.tr,
                                            style: TextStyle(fontFamily: font),
                                          )),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  controller.fontfamily.value = value!;
                                  controller.changeTextTheme();
                                }),
                            const Divider(),
                            Text("Font Size".tr,
                                style: controller
                                    .chaptertexttheme.value.bodyLarge),
                            const Divider(),
                            Slider(
                                value: controller.fontsize.value.toDouble(),
                                min: 20,
                                max: 35,
                                onChanged: (value) {
                                  controller.fontsize.value = value.toInt();
                                  controller.changeTextTheme();
                                }),
                            const Divider(),
                            CheckboxListTile(
                                title: Text("Show Background Image".tr,
                                    style: const TextStyle(fontSize: 22)),
                                value: controller.showBackgroundImage,
                                onChanged: (value) {
                                  value = !value!;
                                  controller.showBackGroundImage();
                                }),
                            const Divider(),
                            DropdownButton<String>(
                                dropdownColor: context.theme.primaryColor,
                                value: controller.currentBackground,
                                style: controller
                                    .chaptertexttheme.value.bodyLarge
                                    ?.copyWith(fontSize: 18),
                                items: controller.backgroundimages
                                    .map(
                                      (image) => DropdownMenuItem<String>(
                                          value: image,
                                          child: Text(image.tr,
                                              style: context
                                                  .theme.textTheme.bodyMedium)),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  controller.changeBackgroundImage(value!);
                                }),
                            const Divider(height: 2, ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Theme'.tr,
                                    style: context.theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              subtitle: SizedBox(
                                height: 100,
                                child: Center(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(
                                        children: <Widget>[
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color:
                                                              borders[index]),
                                                      color: colors[index]),
                                                ),
                                              ),
                                              Text(themes[index],
                                                  style: context.theme.textTheme
                                                      .bodyLarge)
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    switch (index) {
                                                      case 0:
                                                        Get.changeTheme(Themes
                                                            .customLightTheme);
                                                        sharedpref!.setString(
                                                            "theme", "light");
                                                        controller
                                                            .changeTextTheme();
                                                        controller.update();
                                                        break;
                                                      case 1:
                                                        Get.changeTheme(Themes
                                                            .customPurpleTheme);

                                                        sharedpref!.setString(
                                                            "theme", "purple");
                                                        controller
                                                            .changeTextTheme();
                                                        controller.update();
                                                        break;
                                                      case 2:
                                                        Get.changeTheme(Themes
                                                            .customDarkTheme);

                                                        sharedpref!.setString(
                                                            "theme", "dark");
                                                        controller
                                                            .changeTextTheme();
                                                        controller.update();

                                                        break;
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: context.theme
                                                                .primaryColor ==
                                                            colors[index]
                                                        ? Icon(Icons.done,
                                                            color: context
                                                                .theme
                                                                .colorScheme
                                                                .secondary)
                                                        : Container(),
                                                  ),
                                                ),
                                              ),
                                              Text(themes[index],
                                                  style: context.theme.textTheme
                                                      .bodyLarge)
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

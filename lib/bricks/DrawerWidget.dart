import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:hikayat/main.dart';
import 'package:hikayat/theme/theme.dart';

class DrawerWidget extends StatelessWidget {
  final MainController controller = Get.find();
 
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
    return GetBuilder<MainController>(builder: (controller) {
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Font family".tr,
                            style: controller.chaptertexttheme.value.bodyLarge),
                        const Divider(),
                        DropdownButton<String>(
                            value: controller.fontfamily.value,
                            style: controller.chaptertexttheme.value.bodyLarge
                                ?.copyWith(fontSize: 18),
                            items: [
                              DropdownMenuItem(
                                  value: "Amiri",
                                  child: Text(
                                    "Amiri".tr,
                                    style: const TextStyle(fontFamily: "Amiri"),
                                  )),
                              DropdownMenuItem(
                                  value: "Cairo",
                                  child: Text(
                                    "Cairo".tr,
                                    style: const TextStyle(fontFamily: "Cairo"),
                                  )),
                              DropdownMenuItem(
                                  value: "Changa",
                                  child: Text(
                                    "Changa".tr,
                                    style:
                                        const TextStyle(fontFamily: "Changa"),
                                  )),
                              DropdownMenuItem(
                                  value: "ElMessiri",
                                  child: Text(
                                    "ElMessiri".tr,
                                    style: const TextStyle(
                                        fontFamily: "ElMessiri"),
                                  )),
                              DropdownMenuItem(
                                  value: "Harmattan",
                                  child: Text(
                                    "Harmattan".tr,
                                    style: const TextStyle(
                                        fontFamily: "Harmattan"),
                                  )),
                              DropdownMenuItem(
                                  value: "Kufi",
                                  child: Text(
                                    "Kufi".tr,
                                    style: const TextStyle(fontFamily: "Kufi"),
                                  )),
                              DropdownMenuItem(
                                  value: "Lateef",
                                  child: Text(
                                    "Lateef".tr,
                                    style:
                                        const TextStyle(fontFamily: "Lateef"),
                                  )),
                              DropdownMenuItem(
                                  value: "MarkaziText".tr,
                                  child: Text(
                                    "MarkaziText".tr,
                                    style: const TextStyle(
                                        fontFamily: "MarkaziText"),
                                  )),
                              DropdownMenuItem(
                                  value: "ReemKufi",
                                  child: Text(
                                    "ReemKufi".tr,
                                    style:
                                        const TextStyle(fontFamily: "ReemKufi"),
                                  )),
                              DropdownMenuItem(
                                  value: "Rajawal",
                                  child: Text(
                                    "Tajawal".tr,
                                    style:
                                        const TextStyle(fontFamily: "Tajawal"),
                                  )),
                              DropdownMenuItem(
                                  value: "Mada",
                                  child: Text(
                                    "Mada".tr,
                                    style: const TextStyle(fontFamily: "Mada"),
                                  )),
                              DropdownMenuItem(
                                  value: "Marhey",
                                  child: Text(
                                    "Marhey".tr,
                                    style:
                                        const TextStyle(fontFamily: "Marhey"),
                                  )),
                              DropdownMenuItem(
                                  value: "SansArabic".tr,
                                  child: Text(
                                    "SansArabic".tr,
                                    style: const TextStyle(
                                        fontFamily: "SansArabic"),
                                  )),
                              DropdownMenuItem(
                                  value: "Lalezar",
                                  child: Text(
                                    "Lalezar".tr,
                                    style:
                                        const TextStyle(fontFamily: "Lalezar"),
                                  )),
                            ],
                            onChanged: (value) {
                              controller.fontfamily.value = value!;
                              controller.changeTextTheme();
                            }),
                        const Divider(),
                        Text("Font Size".tr,
                            style: controller.chaptertexttheme.value.bodyLarge),
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
                            title: Text("Add Background Image".tr,
                                style: const TextStyle(fontSize: 22)),
                            value:  controller.showBackgroundImage,
                            onChanged: (value) {
                              value = !value!;
                              controller.changeBackgroundImage();
                              
                            }),
                      ],
                    );
                  }),
                ),
              ),
            ),
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
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2, color: borders[index]),
                                      color: colors[index]),
                                ),
                              ),
                              Text(themes[index],
                                  style: context.theme.textTheme.bodyLarge)
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.changeTheme(
                                            Themes.customLightTheme);
                                        sharedpref!.setString("theme", "light");
                                        controller.changeTextTheme();
                                        controller.update();
                                        break;
                                      case 1:
                                        Get.changeTheme(
                                            Themes.customPurpleTheme);

                                        sharedpref!
                                            .setString("theme", "purple");
                                        controller.changeTextTheme();
                                        controller.update();
                                        break;
                                      case 2:
                                        Get.changeTheme(Themes.customDarkTheme);

                                        sharedpref!.setString("theme", "dark");
                                        controller.changeTextTheme();
                                        controller.update();

                                        break;
                                    }
                                  },
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: context.theme.primaryColor ==
                                            colors[index]
                                        ? Icon(Icons.done,
                                            color: context
                                                .theme.colorScheme.secondary)
                                        : Container(),
                                  ),
                                ),
                              ),
                              Text(themes[index],
                                  style: context.theme.textTheme.bodyLarge)
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
        ),
      );
    });
  }
}

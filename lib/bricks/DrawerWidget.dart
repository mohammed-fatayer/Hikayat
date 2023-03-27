import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/MainController.dart';
import 'package:hikayat/theme/theme.dart';

class DrawerWidget extends StatelessWidget {
  final MainController controller = Get.find();

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                            backgroundColor: context.theme.colorScheme.secondary,
                            radius: 40,
                            child: Icon(
                              Icons.person_outline,
                              size: 40,
                              color: context.theme.primaryColor,
                            )),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Log In / Sign Up',
                          style: context.theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Theme',
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
                                             controller.update();
                                        break;
                                      case 1:
                                          Get.changeTheme(
                                            Themes.customPurpleTheme);
                                         controller.update();
                                        break;
                                      case 2:
                                     
                                            Get.changeTheme(Themes.customDarkTheme);
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
                                            color:
                                                context.theme.colorScheme.secondary)
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

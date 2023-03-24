import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hikayat/Localizations/local.dart';
import 'package:hikayat/View/ChapterPage.dart';
import 'package:hikayat/View/GenrePage.dart';
import 'package:hikayat/View/StoryPage.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:hikayat/theme/theme.dart';
import 'package:hikayat/utils/mybindings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Localizations/localeController.dart';
import 'firebase_options.dart';
import 'View/MainPage.dart';
import 'package:upgrader/upgrader.dart';



SharedPreferences? sharedpref;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  sharedpref = await SharedPreferences.getInstance();
  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    LocaleController controller = Get.put(LocaleController());
    bool? theme = sharedpref!.getBool("theme");
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PrakTID',
        locale: controller.initlanguage,
        fallbackLocale: const Locale("en"),
        translations: MyLocale(),
        initialBinding: MyBinding(),
        theme: theme == true ? Themes.customDarkTheme : Themes.customLightTheme,
        initialRoute: "/",
        getPages: [
          GetPage(
            name: "/",
            page: () => MainPage(),
          ),
          GetPage(
            name: "/genre",
            page: () => GenrePage( stories: Get.arguments,)
          ),
          GetPage(
            name: "/story",
            page: () => StoryPage( chapters: Get.arguments,)
          ),
          GetPage(
            name: "/chapter",
            page: () => ChapterPage( chapter: Get.arguments,)
          ),

    
        ]);
  }
}

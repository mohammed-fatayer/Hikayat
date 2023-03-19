import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hikayat/Localizations/local.dart';
import 'package:hikayat/theme/theme.dart';
import 'package:hikayat/utils/mybindings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Localizations/localeController.dart';
import 'firebase_options.dart';
import 'View/MainPage.dart';




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
          // GetPage(
          //   name: "/",
          //   page: () => LoginPage(),
          // ),
          // GetPage(
          //   name: "/Register",
          //   page: () => RegisterPage(),
          // ),
          GetPage(
            name: "/",
            page: () => MainPage(),
          ),

    
        ]);
  }
}

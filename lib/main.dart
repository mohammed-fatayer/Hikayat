import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hikayat/Localizations/local.dart';
import 'package:hikayat/View/ChapterPage.dart';
import 'package:hikayat/View/GenrePage.dart';
import 'package:hikayat/View/StoryPage.dart';
import 'package:hikayat/bricks/Onboarding.dart';
import 'package:hikayat/utils/mybindings.dart';
import 'package:hikayat/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Localizations/localeController.dart';
import 'firebase_options.dart';
import 'View/MainPage.dart';
import 'package:upgrader/upgrader.dart';

SharedPreferences? sharedpref;
bool showOnBoarding = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedpref = await SharedPreferences.getInstance();
  showOnBoarding = sharedpref?.getBool("firstopen") ?? true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    String? theme = sharedpref!.getString("theme");
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hikayat',
        locale: controller.initlanguage,
        fallbackLocale: const Locale("ar"),
        translations: MyLocale(),
        binds: MyBinding().dependencies(),
        theme: theme == "purple"
            ? Themes.customPurpleTheme
            : theme == "dark"
                ? Themes.customDarkTheme
                : Themes.customLightTheme,
        // initialRoute: showOnBoarding ? "/onboarding" : "/",
        getPages: [
          GetPage(
            name: "/",
            page: () => UpgradeAlert(
                upgrader: Upgrader(
                  durationUntilAlertAgain: const Duration(days: 1),
                  showIgnore: false,
                  dialogStyle: GetPlatform.isAndroid
                      ? UpgradeDialogStyle.material
                      : UpgradeDialogStyle.cupertino,
                ),
                child: MainPage()),
            transition: Transition.noTransition,
          ),
          GetPage(
              name: "/genre",
              page: () => GenrePage(),
              transition: Transition.noTransition),
          GetPage(
              name: "/onboarding",
              page: () => const OnboardingPage1(),
              transition: Transition.noTransition),
          GetPage(
              name: "/story",
              page: () => StoryPage(),
              transition: Transition.noTransition),
          GetPage(
              name: "/chapter",
              page: () => ChapterPage(),
              transition: Transition.noTransition),
        ]);
  }
}

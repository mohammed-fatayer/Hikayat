import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hikayat/Controllers/ad_Controller.dart';
import 'package:hikayat/Localizations/local.dart';
import 'package:hikayat/View/ChapterPage.dart';
import 'package:hikayat/View/GenrePage.dart';
import 'package:hikayat/View/MainPage.dart';
import 'package:hikayat/View/StoryPage.dart';
import 'package:hikayat/bricks/Onboarding.dart';
import 'package:hikayat/firebase_options.dart';
import 'package:hikayat/utils/mybindings.dart';
import 'package:hikayat/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Localizations/localeController.dart';
import 'package:upgrader/upgrader.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

SharedPreferences? sharedpref;
bool showOnBoarding = false;
Adhelper adhelper = Get.put(Adhelper());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  sharedpref = await SharedPreferences.getInstance();
  String? token = await messaging.getToken();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  showOnBoarding = sharedpref?.getBool("firstopen") ?? true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    String? theme = sharedpref!.getString("theme");
    return GetMaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
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
              transition: Transition.noTransition,
              preventDuplicates: false),
          GetPage(
              name: "/chapter",
              page: () => ChapterPage(),
              transition: Transition.noTransition),
        ]);
  }
}

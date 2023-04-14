import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:hikayat/main.dart';

class FirebaseLogEventController extends GetxController {
  Future logEventStoryOpen(String storyname) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'story_open',
      parameters: <String, dynamic>{
        'story_name': storyname,
      },
    );
  }

  Future logEventGenreOpen(String genrename) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'genre_open',
      parameters: <String, dynamic>{
        'genre_name': genrename,
      },
    );
    print("done");
  }

  Future logEventChapterOpen(String chaptername, String storyname) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'chapter_open',
      parameters: <String, dynamic>{
        'chapter_name': "$storyname - $chaptername",
      },
    );
  }

  Future logEventFilterClick(String filtername) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'filter_click',
      parameters: <String, dynamic>{
        'filter_name': filtername,
      },
    );
  }
  //new one for opening search bar 
  Future logEventSearchClick() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'search_click',
    );
  }

  //new one for clicking on telegram
  Future logEventTelegramClick() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'telegram_click',
    );
  }
  //for rate us
  Future logEventRateUsClick() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'rate_us_click',
    );
  }
  //for about us 
  Future logEventAboutUsClick() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'about_us_click',
    );
  }
  //for email us
  Future logEventEmailUsClick() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'email_us_click',
    );
  }
}

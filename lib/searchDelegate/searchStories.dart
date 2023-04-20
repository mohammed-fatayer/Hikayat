import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/Controllers/firebaseLogEventController.dart';
import 'package:hikayat/bricks/SearchResultWidget.dart';

class SearchStories extends SearchDelegate {
  FirebaseLogEventController firebaseLogEventController = Get.find();

  final DataController controller = Get.find();

  @override
  ThemeData appBarTheme(BuildContext context) {
    
    final ThemeData theme = Get.theme;
    final ColorScheme colorScheme = theme.colorScheme.copyWith(
      primary: Get.theme.primaryColor, // set the primary color here
    );
    return ThemeData(
      textTheme: colorScheme.brightness == Brightness.dark
          ? theme.textTheme
          : theme.textTheme.copyWith(
              titleLarge: theme.textTheme.titleLarge!.copyWith(
                color: Get.theme.colorScheme.secondary,
              ),
            ),
      primaryColor: Get.theme.primaryColor,
      appBarTheme: AppBarTheme(
        color: colorScheme.primary,
        systemOverlayStyle: theme.appBarTheme.systemOverlayStyle,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Get.theme.colorScheme.secondary,
        ),
      ),
      colorScheme: colorScheme,
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Get.theme.colorScheme.secondary,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
      color: Get.theme.colorScheme.secondary,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        color: Get.theme.primaryColor.withOpacity(0.8),
      );
    } else {
      return GetBuilder<DataController>(
        builder: (controller) {
          return SearchDelegateResults(
            query: query,
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Container(
        color: Get.theme.primaryColor.withOpacity(0.8),
      );
    } else {
      return GetBuilder<DataController>(
        builder: (controller) {
          return SearchDelegateResults(
            query: query,
          );
        },
      );
    }
  }
}

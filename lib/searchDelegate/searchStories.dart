import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayat/Controllers/DataController.dart';
import 'package:hikayat/bricks/SearchResultWidget.dart';
import 'package:hikayat/theme/theme.dart';

class SearchStories extends SearchDelegate {
  final DataController controller = Get.find();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Get.theme;
    final ColorScheme colorScheme = theme.colorScheme.copyWith(
      primary: Get.theme.primaryColor, // set the primary color here
    );
    return ThemeData(
      primaryColor: Get.theme.primaryColor,
      appBarTheme: AppBarTheme(
        color: colorScheme.surface,
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
        icon: const Icon(
          Icons.clear,
          color: Colors.black12,
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
      color:Colors.black12,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return GetBuilder<DataController>(
      builder: (controller) {
        return Scaffold(
          body: SearchDelegateResults(
            query: query,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GetBuilder<DataController>(
      builder: (controller) {
        return SearchDelegateResults(
          query: query,
        );
      },
    );
  }
}

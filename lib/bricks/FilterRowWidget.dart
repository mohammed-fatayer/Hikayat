import 'package:flutter/material.dart';
import 'package:hikayat/bricks/FilterStorySlider.dart';
import 'package:hikayat/model/DataClass.dart';
import 'package:get/get.dart';

class FilterRowWidget extends StatelessWidget {
  final Story story;
  const FilterRowWidget({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(width: 5),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: story.filter.length,
            itemBuilder: (BuildContext context, int index) {
              final filter = story.filter[index];
              return InkWell(
                onTap: () {
                  //show getx dialog that shows all the stories with this filter and then navigate to that story
                  Get.defaultDialog(
                    title: "Filter",
                    content: Expanded(child: FilterStorySlider(filter: filter)),
                    textConfirm: "Ok",
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.back();
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(filter,
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: Get.theme.colorScheme.secondary,
                      )),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hikayat/model/DataClass.dart';
class FilterRowWidget extends StatelessWidget {
  final Story story;
  const FilterRowWidget({super.key,required this.story});

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
                  print(filter);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    filter,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class WorkoutTileWidget extends StatelessWidget {
  final int index;
  const WorkoutTileWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.1,
      child: ListTile(
        title: Text("Workout $index"),
        subtitle: const Text(
          "5 exercise, 7 sets",
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: getSizeWidth(context, 4),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
          color: AppColor.grey2,
        ),
      ),
    );
  }
}

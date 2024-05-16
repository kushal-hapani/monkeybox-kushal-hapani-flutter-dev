import 'package:flutter/material.dart';
import 'package:workout_routines_app/model/user_exercise_model.dart';

import '../../../utils/utils.dart';

class WorkoutTileWidget extends StatelessWidget {
  final UserExerciseModel userExercise;
  const WorkoutTileWidget({
    super.key,
    required this.userExercise,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.1,
      child: ListTile(
        title: Text(userExercise.workOutName),
        subtitle: Text(
          "${userExercise.exerciseId.length} exercise",
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

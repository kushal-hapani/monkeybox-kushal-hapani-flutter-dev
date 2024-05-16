import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_routines_app/model/user_exercise_model.dart';

final addExerciseProvider = FutureProvider.family<bool, AddExerciseModel>(
  (ref, exerciseModel) async {
    await exerciseModel.exerciseBox.add(exerciseModel.model);
    if (exerciseModel.context.mounted) {
      exerciseModel.context.pop();
    }
    return true;
  },
);

class AddExerciseModel {
  final Box<UserExerciseModel> exerciseBox;
  final UserExerciseModel model;
  final BuildContext context;

  AddExerciseModel({
    required this.exerciseBox,
    required this.model,
    required this.context,
  });
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/user_exercise_model.dart';

final deleteExerciseProvider = FutureProvider.family<bool, DeleteExerciseModel>(
  (ref, deleteModel) async {
    await deleteModel.box.deleteAt(deleteModel.index);

    if (deleteModel.context.mounted) {
      deleteModel.context.pop();
    }
    return true;
  },
);

class DeleteExerciseModel {
  final int index;
  final BuildContext context;
  final Box<UserExerciseModel> box;

  DeleteExerciseModel({
    required this.index,
    required this.context,
    required this.box,
  });
}

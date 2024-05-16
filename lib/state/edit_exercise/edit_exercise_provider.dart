import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../add_exercise/add_exercise_provider.dart';

final editExerciseProvider = FutureProvider.family<bool, UpdateExerciseModel>(
  (ref, exerciseModel) async {
    await exerciseModel.addExerciseModel.exerciseBox
        .putAt(exerciseModel.index, exerciseModel.addExerciseModel.model);

    if (exerciseModel.addExerciseModel.context.mounted) {
      exerciseModel.addExerciseModel.context.pop();
    }
    return true;
  },
);

class UpdateExerciseModel {
  final AddExerciseModel addExerciseModel;
  final int index;

  UpdateExerciseModel({
    required this.addExerciseModel,
    required this.index,
  });
}

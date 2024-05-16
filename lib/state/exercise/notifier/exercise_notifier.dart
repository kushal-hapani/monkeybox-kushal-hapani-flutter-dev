import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_routines_app/state/exercise/model/exercise_model.dart';
import 'package:workout_routines_app/state/exercise/model/exercise_state.dart';

class ExerciseNotifier extends StateNotifier<ExerciseState> {
  ExerciseNotifier() : super(ExerciseState.unKnown());

  Future<void> getExerciseData() async {
    state = state.copiedWithIsLoading(true);
    final loadedJson = await rootBundle.loadString('lib/api/exercise.json');
    final exercises = ExcersiseModel.fromJson(json.decode(loadedJson));

    state = ExerciseState(
      isLoading: false,
      exerciseData: exercises.entity!.data ?? [],
    );
  }
}

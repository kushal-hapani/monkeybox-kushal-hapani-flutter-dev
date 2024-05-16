import 'package:flutter/foundation.dart';
import 'package:workout_routines_app/state/exercise/model/exercise_model.dart';

@immutable
class ExerciseState {
  final bool isLoading;
  final List<ExerciseData> exerciseData;

  const ExerciseState({
    required this.isLoading,
    required this.exerciseData,
  });

  ///When state is not known for [AuthState] we created a named constructor
  ExerciseState.unKnown()
      : exerciseData = [],
        isLoading = false;

  ExerciseState copiedWithIsLoading(bool isLoading) => ExerciseState(
        isLoading: isLoading,
        exerciseData: exerciseData,
      );

  @override
  bool operator ==(covariant ExerciseState other) =>
      (isLoading == other.isLoading && exerciseData == other.exerciseData);

  @override
  int get hashCode => Object.hashAll([isLoading, exerciseData]);
}

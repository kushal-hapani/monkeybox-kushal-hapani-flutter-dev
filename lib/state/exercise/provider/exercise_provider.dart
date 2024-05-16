import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_routines_app/state/exercise/model/exercise_state.dart';
import 'package:workout_routines_app/state/exercise/notifier/exercise_notifier.dart';

final exerciseProvider = StateNotifierProvider<ExerciseNotifier, ExerciseState>(
  (ref) {
    return ExerciseNotifier();
  },
);

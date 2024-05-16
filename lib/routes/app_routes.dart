import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_routines_app/model/user_exercise_model.dart';
import 'package:workout_routines_app/view/exercise/add_exercise_screen.dart';
import 'package:workout_routines_app/view/home/edit_exercise_screen.dart';
import 'package:workout_routines_app/view/home/exercise_detail_screen.dart';
import 'package:workout_routines_app/view/home/home_screen.dart';

class AppRoutes {
  static const String homeScreen = "/";
  static const String addExercise = "add_exercise";
  static const String editExerciseScreen = "edit_exercise_screen";
  static const String exerciseDetail = "exercise_detail";
}

class AppRoutesConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
          path: AppRoutes.homeScreen,
          name: AppRoutes.homeScreen,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: HomeScreen(),
            );
          },
          routes: [
            GoRoute(
              path:
                  '${AppRoutes.addExercise}/:${ParameterConstant.exerciseName}',
              name: AppRoutes.addExercise,
              pageBuilder: (context, state) {
                final exerciseName =
                    state.pathParameters[ParameterConstant.exerciseName];

                return MaterialPage(
                  child: AddExerciseScreen(
                    exerciseName: exerciseName ?? '',
                  ),
                );
              },
            ),
            GoRoute(
              path: '${AppRoutes.editExerciseScreen}/:index',
              name: AppRoutes.editExerciseScreen,
              pageBuilder: (context, state) {
                final userExercise = state.extra as UserExerciseModel;
                final index = state.pathParameters['index'] as String;
                return MaterialPage(
                  child: EditExerciseScreen(
                    userExercise: userExercise,
                    index: int.parse(index),
                  ),
                );
              },
            ),
            GoRoute(
              path: AppRoutes.exerciseDetail,
              name: AppRoutes.exerciseDetail,
              pageBuilder: (context, state) {
                final userExercise = state.extra as List;

                return MaterialPage(
                  child: ExerciseDetailScreen(
                    userExercise: userExercise[0] as UserExerciseModel,
                    index: userExercise[1] as int,
                  ),
                );
              },
            ),
          ]),
    ],
  );
}

class ParameterConstant {
  static const String exerciseName = 'exerciseName';
}

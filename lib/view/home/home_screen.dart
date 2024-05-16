import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_routines_app/model/user_exercise_model.dart';
import 'package:workout_routines_app/routes/app_routes.dart';
import 'package:workout_routines_app/utils/utils.dart';
import 'package:workout_routines_app/view/home/widget/add_name_bottom_sheet.dart';
import 'package:workout_routines_app/view/home/widget/search_textfield.dart';
import 'package:workout_routines_app/view/home/widget/workout_tile_widget.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTextController = useTextEditingController();
    final searchValue = useState('');
    Box<UserExerciseModel> userExercises =
        Hive.box(ConstantString.userExerciseBox);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getSizeWidth(context, 4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              2.0.toVSB(context),

              SearchTextfield(
                controller: searchTextController,
                onChange: (value) {
                  searchValue.value = value ?? '';
                },
              ),
              2.0.toVSB(context),
              ValueListenableBuilder(
                valueListenable: userExercises.listenable(),
                builder: (context, box, child) {
                  final totalWorkout = box.values
                      .toList()
                      .where((element) => element.workOutName
                          .toLowerCase()
                          .contains(searchValue.value.toLowerCase()))
                      .toList()
                      .length;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Strength Training",
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "$totalWorkout Workout",
                        style: const TextStyle(
                          color: AppColor.grey1,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                },
              ),

              //
              ValueListenableBuilder(
                valueListenable: userExercises.listenable(),
                builder: (context, box, child) {
                  final userExercises = box.values.toList();

                  return ListView.builder(
                    itemCount: userExercises
                        .where((element) => element.workOutName
                            .toLowerCase()
                            .contains(searchValue.value.toLowerCase()))
                        .length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: getSizeHeight(context, 1.5),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final userExercise = userExercises
                          .where((element) => element.workOutName
                              .toLowerCase()
                              .contains(searchValue.value.toLowerCase()))
                          .toList()[index];
                      return GestureDetector(
                        onTap: () {
                          final i = box.values.toList().indexWhere(
                              (element) => element.id == userExercise.id);

                          context.pushNamed(
                            AppRoutes.exerciseDetail,
                            extra: [userExercise, i],
                          );
                        },
                        child: WorkoutTileWidget(
                          userExercise: userExercise,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showModalBottomSheet<String>(
            context: context,
            backgroundColor: AppColor.transparent,
            isScrollControlled: true,
            builder: (context) {
              return const AddWorkoutNameBottomSheet();
            },
          );

          if (result == null) return;
          if (result.isEmpty) return;

          if (context.mounted) {
            context.pushNamed(
              AppRoutes.addExercise,
              pathParameters: {
                ParameterConstant.exerciseName: result,
              },
            );
          }
        },
        backgroundColor: AppColor.black,
        icon: const Icon(
          Icons.add,
          color: AppColor.white,
        ),
        label: const Text(
          "Add Workout",
          style: TextStyle(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

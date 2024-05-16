import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_routines_app/model/user_exercise_model.dart';
import 'package:workout_routines_app/routes/app_routes.dart';
import 'package:workout_routines_app/state/delete_exercise/delete_exercise.dart';
import 'package:workout_routines_app/state/exercise/model/exercise_model.dart';
import 'package:workout_routines_app/state/exercise/provider/exercise_provider.dart';
import 'package:workout_routines_app/utils/enum.dart';
import 'package:workout_routines_app/utils/utils.dart';

class ExerciseDetailScreen extends HookConsumerWidget {
  final UserExerciseModel userExercise;
  final int index;
  const ExerciseDetailScreen({
    super.key,
    required this.userExercise,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(exerciseProvider).isLoading;
    final userExerciseData = useState(<ExerciseData>[]);
    Box<UserExerciseModel> userExercises =
        Hive.box(ConstantString.userExerciseBox);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ref.read(exerciseProvider.notifier).getExerciseData();
        final exercisesData = ref.watch(exerciseProvider).exerciseData;

        final exercises = <ExerciseData>[];
        for (final ids in userExercise.exerciseId) {
          final exercise =
              exercisesData.where((element) => element.id! == ids).first;
          exercises.add(exercise);
        }
        userExerciseData.value = exercises;
      });
      return;
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: AppColor.transparent,
        title: Text(
          userExercise.workOutName,
          style: const TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: AppColor.white,
            surfaceTintColor: AppColor.white,
            onSelected: (value) async {
              switch (value) {
                case ExersiceOptions.edit:
                  context.pushReplacementNamed(
                    AppRoutes.editExerciseScreen,
                    extra: userExercise,
                    pathParameters: {
                      'index': index.toString(),
                    },
                  );
                case ExersiceOptions.delete:
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: AppColor.white,
                        surfaceTintColor: AppColor.white,
                        title: const Text(
                          'Delete workout',
                        ),
                        content: const Text(
                          "Are you sure you want to delete this dialog",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.pop(false);
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                (states) => AppColor.yellow.withOpacity(.5),
                              ),
                            ),
                            child: const Text(
                              'No',
                              style: TextStyle(
                                color: AppColor.darkYellow,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pop(true);
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                (states) => AppColor.yellow.withOpacity(.5),
                              ),
                            ),
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: AppColor.darkYellow,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  if (result == null) return;
                  if (!result) return;
                  if (!context.mounted) return;

                  final deleteModel = DeleteExerciseModel(
                    index: index,
                    context: context,
                    box: userExercises,
                  );

                  ref.read(deleteExerciseProvider(deleteModel));
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (context) =>
                List.generate(ExersiceOptions.values.length, (i) {
              final options = ExersiceOptions.values[i];
              return PopupMenuItem<ExersiceOptions>(
                value: options,
                child: Text(options.name.capitalize()),
              );
            }),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          .5.toVSB(context),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.yellow,
                    ),
                  )
                : ListView.builder(
                    itemCount: userExerciseData.value.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: getSizeWidth(context, 4),
                    ),
                    itemBuilder: (_, index) {
                      final exercise = userExerciseData.value[index];
                      return Card(
                        color: AppColor.white,
                        elevation: .1,
                        child: Theme(
                          data: ThemeData()
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.symmetric(
                              horizontal: getSizeWidth(context, 3),
                            ),
                            title: Text(exercise.name!),
                            leading: exercise.angle0Image == null
                                ? null
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: exercise.angle0Image!,
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getSizeWidth(context, 4),
                                  vertical: getSizeHeight(context, 2),
                                ),
                                child: Text(
                                  exercise.description ??
                                      'No description found',
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

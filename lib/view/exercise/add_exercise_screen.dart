import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_routines_app/model/user_exercise_model.dart';
import 'package:workout_routines_app/state/add_exercise/add_exercise_provider.dart';
import 'package:workout_routines_app/state/exercise/model/exercise_model.dart';
import 'package:workout_routines_app/state/exercise/provider/exercise_provider.dart';
import 'package:workout_routines_app/utils/utils.dart';
import 'package:workout_routines_app/view/exercise/widget/category_filter_bottom_sheet.dart';
import 'package:workout_routines_app/view/exercise/widget/equipments_filter_bottom_sheet.dart';
import 'package:workout_routines_app/view/exercise/widget/main_muscle_bottom_sheet.dart';
import 'package:workout_routines_app/view/exercise/widget/secondary_muscle_bottom_sheet.dart';
import 'package:workout_routines_app/view/home/widget/search_textfield.dart';

class AddExerciseScreen extends HookConsumerWidget {
  final String exerciseName;
  const AddExerciseScreen({
    super.key,
    required this.exerciseName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseData = ref.watch(exerciseProvider).exerciseData;

    final filterExerciseData = useState(<ExerciseData>[]);

    final isLoadng = ref.watch(exerciseProvider).isLoading;
    Box<UserExerciseModel> userExercises =
        Hive.box(ConstantString.userExerciseBox);

    final searchTextController = useTextEditingController();
    final isFiltered = useState(false);
    final showFilters = useState(false);
    final searchResult = useState(<ExerciseData>[]);
    final selectedId = useState(<String>[]);

    final selectedEqIds = useState(<String>[]);
    final selectedMMIds = useState(<String>[]);
    final selectedSMIds = useState(<String>[]);
    final selectedCIds = useState(<String>[]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ref.read(exerciseProvider.notifier).getExerciseData();
        filterExerciseData.value = ref.watch(exerciseProvider).exerciseData;
      });

      return;
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: AppColor.transparent,
        title: const Text(
          "Add exercise",
          style: TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showFilters.value = !showFilters.value;

              if (!showFilters.value) {
                isFiltered.value = false;
                filterExerciseData.value = exerciseData;
                selectedEqIds.value = [];
                selectedMMIds.value = [];
                selectedSMIds.value = [];
                selectedCIds.value = [];
              }
            },
            icon: Icon(
              showFilters.value
                  ? Icons.filter_list_off_rounded
                  : Icons.filter_list_rounded,
              color: AppColor.black,
            ),
          ),
        ],
      ),
      body: isLoadng
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.yellow,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: getSizeWidth(context, 4),
                    right: getSizeWidth(context, 4),
                    top: getSizeHeight(context, 2),
                    bottom: getSizeHeight(context, 1.5),
                  ),
                  child: SearchTextfield(
                    controller: searchTextController,
                    onChange: (value) {
                      isFiltered.value = value!.isNotEmpty;

                      searchResult.value = filterExerciseData.value
                          .where((element) => element.name!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    },
                  ),
                ),

                if (showFilters.value)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: getSizeWidth(context, 4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildFilterChips(
                          context,
                          onTap: () async {
                            final equipments = getEquipmentsList(
                              exerciseData: exerciseData,
                            );

                            final result =
                                await showModalBottomSheet<List<String>>(
                              context: context,
                              builder: (context) {
                                return EquipmentsFilterBottomSheet(
                                  selectedId: selectedEqIds.value,
                                  equipmentsList: equipments,
                                );
                              },
                            );

                            if (result == null) return;
                            selectedEqIds.value = result;

                            filterExerciseData.value = await getFilteredList(
                              exerciseData: exerciseData,
                              filteredData: filterExerciseData.value,
                              selectedEqId: selectedEqIds.value,
                              selectedCId: selectedCIds.value,
                              selectedMMId: selectedMMIds.value,
                              selectedSMId: selectedSMIds.value,
                            );
                          },
                          title: "Equipments",
                        ),
                        buildFilterChips(
                          context,
                          onTap: () async {
                            final mainMuscles = getMainMuscleList(
                              exerciseData: exerciseData,
                            );

                            final result =
                                await showModalBottomSheet<List<String>>(
                              context: context,
                              builder: (context) {
                                return MainMuscleFilterBottomSheet(
                                  selectedId: selectedMMIds.value,
                                  mainMusclesList: mainMuscles,
                                );
                              },
                            );

                            if (result == null) return;
                            selectedMMIds.value = result;

                            filterExerciseData.value = await getFilteredList(
                              exerciseData: exerciseData,
                              filteredData: filterExerciseData.value,
                              selectedEqId: selectedEqIds.value,
                              selectedCId: selectedCIds.value,
                              selectedMMId: selectedMMIds.value,
                              selectedSMId: selectedSMIds.value,
                            );
                          },
                          title: "Main muscle",
                        ),
                        buildFilterChips(
                          context,
                          onTap: () async {
                            final secondaryMuscle = getSecondaryMuscles(
                              exerciseData: exerciseData,
                            );

                            final result =
                                await showModalBottomSheet<List<String>>(
                              context: context,
                              builder: (context) {
                                return SecondaryMuscleFilterBottomSheet(
                                  selectedId: selectedSMIds.value,
                                  secondaryMusclesList: secondaryMuscle,
                                );
                              },
                            );

                            if (result == null) return;
                            selectedSMIds.value = result;

                            filterExerciseData.value = await getFilteredList(
                              exerciseData: exerciseData,
                              filteredData: filterExerciseData.value,
                              selectedEqId: selectedEqIds.value,
                              selectedCId: selectedCIds.value,
                              selectedMMId: selectedMMIds.value,
                              selectedSMId: selectedSMIds.value,
                            );
                          },
                          title: "Secondary muscle",
                        ),
                        buildFilterChips(
                          context,
                          onTap: () async {
                            final category = getCategorys(
                              exerciseData: exerciseData,
                            );

                            final result =
                                await showModalBottomSheet<List<String>>(
                              context: context,
                              builder: (context) {
                                return CategoryFilterBottomSheet(
                                  selectedId: selectedCIds.value,
                                  categoryList: category,
                                );
                              },
                            );

                            if (result == null) return;
                            selectedCIds.value = result;

                            filterExerciseData.value = await getFilteredList(
                              exerciseData: exerciseData,
                              filteredData: filterExerciseData.value,
                              selectedEqId: selectedEqIds.value,
                              selectedCId: selectedCIds.value,
                              selectedMMId: selectedMMIds.value,
                              selectedSMId: selectedSMIds.value,
                            );
                          },
                          title: "Categories",
                        ),
                      ].addHSpacing(getSizeWidth(context, 2)),
                    ),
                  ),

                //
                Expanded(
                  child: ListView.builder(
                    itemCount: isFiltered.value
                        ? searchResult.value.length
                        : filterExerciseData.value.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        bottom: getSizeHeight(context, 2),
                        left: getSizeWidth(context, 4),
                        right: getSizeWidth(context, 4),
                        top: getSizeHeight(context, 1.5)),
                    itemBuilder: (context, index) {
                      final exercise = isFiltered.value
                          ? searchResult.value[index]
                          : filterExerciseData.value[index];
                      return Card(
                        color: AppColor.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0.1,
                        child: ListTile(
                          onTap: () {
                            if (selectedId.value.contains(exercise.id!)) {
                              selectedId.value = List.from(selectedId.value)
                                ..remove(exercise.id!);
                            } else {
                              selectedId.value = List.from(selectedId.value)
                                ..add(exercise.id!);
                            }
                          },
                          leading: exercise.angle0Image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: exercise.angle0Image!,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : null,
                          title: Text(exercise.name!),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getSizeWidth(context, 4),
                          ),
                          trailing: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: selectedId.value.contains(exercise.id!)
                                  ? AppColor.darkYellow
                                  : null,
                              border: selectedId.value.contains(exercise.id!)
                                  ? Border.all(color: AppColor.darkYellow)
                                  : Border.all(color: AppColor.grey2),
                              shape: BoxShape.circle,
                            ),
                            child: selectedId.value.contains(exercise.id!)
                                ? const Icon(
                                    Icons.check,
                                    color: AppColor.white,
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: selectedId.value.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                var uuid = const Uuid();
                final userExercise = UserExerciseModel(
                  id: uuid.v4(),
                  workOutName: exerciseName,
                  createdAt: DateTime.now(),
                  exerciseId: selectedId.value,
                );

                final addExercideModel = AddExerciseModel(
                  exerciseBox: userExercises,
                  model: userExercise,
                  context: context,
                );

                ref.read(addExerciseProvider(addExercideModel));
              },
              backgroundColor: AppColor.black,
              icon: const Icon(
                Icons.add,
                color: AppColor.white,
              ),
              label: const Text(
                "Add",
                style: TextStyle(
                  color: AppColor.white,
                ),
              ),
            ),
    );
  }

  GestureDetector buildFilterChips(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              title,
            ),
            1.0.toHSB(context),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColor.black,
            )
          ],
        ),
      ),
    );
  }

  List<Equipments> getEquipmentsList({
    required List<ExerciseData> exerciseData,
  }) {
    final equipments = <Equipments>[];

    for (final exercise in exerciseData) {
      for (final equipment in exercise.equipments!) {
        if (equipments.contains(equipment)) {
          "Here".log();
          continue;
        } else {
          equipments.add(equipment);
        }
      }
    }

    return equipments;
  }

  List<MainMuscles> getMainMuscleList({
    required List<ExerciseData> exerciseData,
  }) {
    final mainMuscles = <MainMuscles>[];

    for (final exercise in exerciseData) {
      for (final mainMuscle in exercise.mainMuscles!) {
        if (mainMuscles.contains(mainMuscle)) {
          continue;
        } else {
          mainMuscles.add(mainMuscle);
        }
      }
    }

    return mainMuscles;
  }

  List<SecondaryMuscles> getSecondaryMuscles({
    required List<ExerciseData> exerciseData,
  }) {
    final secondaryMuscles = <SecondaryMuscles>[];

    for (final exercise in exerciseData) {
      for (final secondaryMuscle in exercise.secondaryMuscles!) {
        if (secondaryMuscles.contains(secondaryMuscle)) {
          continue;
        } else {
          secondaryMuscles.add(secondaryMuscle);
        }
      }
    }

    return secondaryMuscles;
  }

  List<Categories> getCategorys({
    required List<ExerciseData> exerciseData,
  }) {
    final categories = <Categories>[];

    for (final exercise in exerciseData) {
      for (final categorie in exercise.categories!) {
        if (categories.contains(categorie)) {
          continue;
        } else {
          categories.add(categorie);
        }
      }
    }

    return categories;
  }

  Future<List<ExerciseData>> getFilteredList({
    required List<ExerciseData> exerciseData,
    required List<ExerciseData> filteredData,
    required List<String> selectedEqId,
    required List<String> selectedMMId,
    required List<String> selectedSMId,
    required List<String> selectedCId,
  }) async {
    List<ExerciseData> finalExerciseData = <ExerciseData>[];

    if (selectedEqId.isNotEmpty) {
      for (final exercise in exerciseData) {
        for (final equipment in exercise.equipments!) {
          if (selectedEqId.contains(equipment.id)) {
            finalExerciseData.add(exercise);
          }
        }
      }
    }

    await Future.delayed(const Duration(microseconds: 100));

    if (selectedMMId.isNotEmpty) {
      for (final exercise in exerciseData) {
        for (final mainMuscles in exercise.mainMuscles!) {
          if (selectedMMId.contains(mainMuscles.id)) {
            if (!finalExerciseData.contains(exercise)) {
              finalExerciseData.add(exercise);
            }
          }
        }
      }
    }

    await Future.delayed(const Duration(microseconds: 100));

    if (selectedSMId.isNotEmpty) {
      for (final exercise in exerciseData) {
        for (final secMuscles in exercise.secondaryMuscles!) {
          "secMuscles.id -> ${secMuscles.id}".log();

          if (selectedSMId.contains(secMuscles.id)) {
            "Contaims id -> ${secMuscles.id} in $selectedSMId".log();
            if (!finalExerciseData.contains(exercise)) {
              finalExerciseData.add(exercise);
            }
          }
        }
      }
    }

    await Future.delayed(const Duration(microseconds: 100));

    if (selectedCId.isNotEmpty) {
      for (final exercise in exerciseData) {
        for (final category in exercise.categories!) {
          if (selectedCId.contains(category.id)) {
            if (!finalExerciseData.contains(exercise)) {
              finalExerciseData.add(exercise);
            }
          }
        }
      }
    }

    if (selectedCId.isEmpty &&
        selectedEqId.isEmpty &&
        selectedMMId.isEmpty &&
        selectedSMId.isEmpty) {
      finalExerciseData = exerciseData;
    }

    'Filtered ${finalExerciseData.length}'.log();
    return finalExerciseData;
  }
}

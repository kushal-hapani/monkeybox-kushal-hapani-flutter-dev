import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_routines_app/utils/utils.dart';
import 'package:workout_routines_app/widget/app_button.dart';

import '../../../state/exercise/model/exercise_model.dart';

class MainMuscleFilterBottomSheet extends HookWidget {
  final List<String> selectedId;
  final List<MainMuscles> mainMusclesList;

  const MainMuscleFilterBottomSheet({
    super.key,
    required this.selectedId,
    required this.mainMusclesList,
  });

  @override
  Widget build(BuildContext context) {
    final selectedId = useState(this.selectedId);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Main Muscles",
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: AppColor.grey2,
                ),
              )
            ],
          ),

          //
          Expanded(
            child: ListView.builder(
              itemCount: mainMusclesList.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final mainMuscles = mainMusclesList[index];

                return Card(
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0.5,
                  child: ListTile(
                    onTap: () {
                      if (selectedId.value.contains(mainMuscles.id!)) {
                        selectedId.value = List.from(selectedId.value)
                          ..remove(mainMuscles.id!);
                      } else {
                        selectedId.value = List.from(selectedId.value)
                          ..add(mainMuscles.id!);
                      }
                    },
                    title: Text(mainMuscles.name!),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getSizeWidth(context, 4),
                    ),
                    trailing: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: selectedId.value.contains(mainMuscles.id!)
                            ? AppColor.darkYellow
                            : null,
                        border: selectedId.value.contains(mainMuscles.id!)
                            ? Border.all(color: AppColor.darkYellow)
                            : Border.all(color: AppColor.grey2),
                        shape: BoxShape.circle,
                      ),
                      child: selectedId.value.contains(mainMuscles.id!)
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

          //
          AppButton(
            onTap: () {
              context.pop(selectedId.value);
            },
            buttonTitle: "Filter",
          ),

          2.0.toVSB(context),
        ],
      ),
    );
  }
}

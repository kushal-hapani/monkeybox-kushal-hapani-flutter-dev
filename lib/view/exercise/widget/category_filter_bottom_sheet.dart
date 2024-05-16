import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_routines_app/utils/utils.dart';
import 'package:workout_routines_app/widget/app_button.dart';

import '../../../state/exercise/model/exercise_model.dart';

class CategoryFilterBottomSheet extends HookWidget {
  final List<String> selectedId;
  final List<Categories> categoryList;

  const CategoryFilterBottomSheet({
    super.key,
    required this.selectedId,
    required this.categoryList,
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
                "Categories",
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
              itemCount: categoryList.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final category = categoryList[index];

                return Card(
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0.5,
                  child: ListTile(
                    onTap: () {
                      if (selectedId.value.contains(category.id!)) {
                        selectedId.value = List.from(selectedId.value)
                          ..remove(category.id!);
                      } else {
                        selectedId.value = List.from(selectedId.value)
                          ..add(category.id!);
                      }
                    },
                    title: Text(category.name!),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getSizeWidth(context, 4),
                    ),
                    trailing: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: selectedId.value.contains(category.id!)
                            ? AppColor.darkYellow
                            : null,
                        border: selectedId.value.contains(category.id!)
                            ? Border.all(color: AppColor.darkYellow)
                            : Border.all(color: AppColor.grey2),
                        shape: BoxShape.circle,
                      ),
                      child: selectedId.value.contains(category.id!)
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

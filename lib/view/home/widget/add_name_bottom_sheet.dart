import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_routines_app/view/home/widget/search_textfield.dart';
import 'package:workout_routines_app/widget/app_button.dart';

import '../../../utils/utils.dart';

class AddWorkoutNameBottomSheet extends HookWidget {
  const AddWorkoutNameBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
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
                  "Workout Name",
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () => context.pop(""),
                  icon: const Icon(
                    Icons.close,
                    color: AppColor.grey2,
                  ),
                )
              ],
            ),
            .5.toVSB(context),
            TextField(
              autofocus: true,
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter workout name",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: getSizeWidth(context, 4),
                ),
                border: outlinedInputBorder(radius: 12),
                focusedBorder: outlinedInputBorder(radius: 12),
                enabledBorder: outlinedInputBorder(radius: 12),
              ),
            ),
            2.0.toVSB(context),
            AppButton(
              onTap: () {
                context.pop(nameController.text.trim());
              },
              buttonTitle: "Next",
            ),
          ],
        ),
      ),
    );
  }
}

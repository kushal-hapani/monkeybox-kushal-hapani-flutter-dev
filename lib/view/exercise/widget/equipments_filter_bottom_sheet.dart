import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../state/exercise/model/exercise_model.dart';
import '../../../utils/utils.dart';
import '../../../widget/app_button.dart';

class EquipmentsFilterBottomSheet extends HookWidget {
  final List<String> selectedId;
  final List<Equipments> equipmentsList;

  const EquipmentsFilterBottomSheet({
    super.key,
    required this.selectedId,
    required this.equipmentsList,
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
                "Equipments",
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {},
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
              itemCount: equipmentsList.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final equipment = equipmentsList[index];

                return Card(
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0.5,
                  child: ListTile(
                    onTap: () {
                      if (selectedId.value.contains(equipment.id!)) {
                        selectedId.value = List.from(selectedId.value)
                          ..remove(equipment.id!);
                      } else {
                        selectedId.value = List.from(selectedId.value)
                          ..add(equipment.id!);
                      }
                    },
                    title: Text(equipment.name!),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getSizeWidth(context, 4),
                    ),
                    trailing: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: selectedId.value.contains(equipment.id!)
                            ? AppColor.darkYellow
                            : null,
                        border: selectedId.value.contains(equipment.id!)
                            ? Border.all(color: AppColor.darkYellow)
                            : Border.all(color: AppColor.grey2),
                        shape: BoxShape.circle,
                      ),
                      child: selectedId.value.contains(equipment.id!)
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

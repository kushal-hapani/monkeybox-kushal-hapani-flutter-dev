import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:workout_routines_app/gen/assets.gen.dart';

import '../../../utils/utils.dart';

class SearchTextfield extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onChange;
  const SearchTextfield({
    super.key,
    required this.controller,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChange,
      decoration: InputDecoration(
        fillColor: AppColor.white,
        filled: true,
        hintText: "Search Workout...",
        contentPadding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: getSizeWidth(context, 4),
        ),
        border: outlinedInputBorder(),
        focusedBorder: outlinedInputBorder(),
        enabledBorder: outlinedInputBorder(),
        prefixIcon: IconButton(
          onPressed: null,
          icon: SvgPicture.asset(
            Assets.images.search,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder outlinedInputBorder({double radius = 50}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: const BorderSide(
      color: AppColor.yellow,
    ),
  );
}

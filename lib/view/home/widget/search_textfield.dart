import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:workout_routines_app/gen/assets.gen.dart';

import '../../../utils/utils.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColor.yellow,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getSizeWidth(context, 4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.images.search,
            height: 24,
            width: 24,
          ),

          2.0.toHSB(context),

          //
          const Text(
            "Search Routines",
            style: TextStyle(
                color: AppColor.grey1,
                fontWeight: FontWeight.w400,
                fontSize: 16),
          )
        ],
      ),
    );
  }
}

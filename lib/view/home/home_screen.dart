import 'package:flutter/material.dart';
import 'package:workout_routines_app/utils/utils.dart';
import 'package:workout_routines_app/view/home/widget/search_textfield.dart';
import 'package:workout_routines_app/view/home/widget/workout_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              const SearchTextfield(),

              2.0.toVSB(context),

              //
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Strength Training",
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "1 Workout",
                    style: TextStyle(
                      color: AppColor.grey1,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),

              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  top: getSizeHeight(context, 1.5),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return WorkoutTileWidget(index: index);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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

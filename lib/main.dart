import 'package:flutter/material.dart';
import 'package:workout_routines_app/routes/app_routes.dart';
import 'package:workout_routines_app/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final appRoutesConfig = AppRoutesConfig();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Workout Let\'s Go!',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColor.scaffoldBgColor,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: appRoutesConfig.goRouter,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workout_routines_app/model/user_exercise_model.dart';
import 'package:workout_routines_app/routes/app_routes.dart';
import 'package:workout_routines_app/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();

  await Hive.initFlutter(document.path);

  Hive.registerAdapter(UserExerciseModelAdapter());
  await Hive.openBox<UserExerciseModel>(ConstantString.userExerciseBox);

  runApp(const ProviderScope(child: MyApp()));
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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.black,
          selectionColor: AppColor.yellow.withOpacity(.3),
          selectionHandleColor: AppColor.yellow,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: appRoutesConfig.goRouter,
    );
  }
}

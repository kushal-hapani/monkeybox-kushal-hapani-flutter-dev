import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_routines_app/view/home/home_screen.dart';

class AppRoutes {
  static const String homeScreen = "/";
}

class AppRoutesConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HomeScreen(),
          );
        },
      ),
    ],
  );
}

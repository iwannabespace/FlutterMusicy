import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import '../navigation/app_router.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    // ..progressColor = Colors.red
    // ..backgroundColor = darkColorScheme.background
    // ..indicatorColor = darkColorScheme.secondary
    // ..textColor = darkColorScheme.onBackground
    // ..maskColor = darkColorScheme.background.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;

  getIt.registerLazySingleton<GoRouter>(() => router);

  getIt.registerLazySingleton<BottomNavigationCubit>(
      () => BottomNavigationCubit());
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../di/injection_container.dart';
import '../features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';

class MusicyApp extends StatelessWidget {
  const MusicyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationCubit>(
          create: (context) => getIt<BottomNavigationCubit>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          // colorScheme: lightColorScheme,
          // extensions: [lightCustomColors],
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          // colorScheme: darkColorScheme,
          // extensions: [darkCustomColors],
        ),
        themeMode: ThemeMode.dark,
        routerConfig: getIt<GoRouter>(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

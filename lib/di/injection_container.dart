import 'package:audio_service/audio_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:musicy/audio_handler/audio_handler.dart';
import 'package:musicy/core/network/network_info.dart';
import 'package:musicy/features/music/data/datasources/remote_music_data_source.dart';
import 'package:musicy/features/music/data/repositories/music_repository_impl.dart';
import 'package:musicy/features/music/domain/entities/music.dart';
import 'package:musicy/features/music/domain/repositories/music_repository.dart';
import 'package:musicy/features/music/domain/usecases/download_music_usecase.dart';
import 'package:musicy/features/music/presentation/cubit/music_cubit.dart';

import '../features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import '../features/music/data/datasources/local_music_data_source.dart';
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

  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfo(connectivity: getIt()),
  );
  getIt.registerLazySingleton<GoRouter>(() => router);

  getIt.registerLazySingleton<MusicAdapter>(() => MusicAdapter());

  getIt.registerLazySingleton<MusicRemoteDataSource>(
      () => MusicRemoteDataSourceImpl(dio: getIt()));
  getIt.registerLazySingleton<MusicLocalDataSource>(
      () => MusicLocalDataSourceImpl());

  getIt.registerFactory<MusicRepository>(() => MusicRepositoryImpl(
      musicRemoteDataSource: getIt(),
      musicLocalDataSource: getIt(),
      networkInfo: getIt()));

  getIt.registerFactory<DownloadMusicUseCase>(
      () => DownloadMusicUseCase(musicRepository: getIt()));

  getIt.registerLazySingleton<BottomNavigationCubit>(
      () => BottomNavigationCubit());
  getIt.registerLazySingleton<MusicCubit>(
      () => MusicCubit(downloadMusicUseCase: getIt()));
}

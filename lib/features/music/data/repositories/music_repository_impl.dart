import 'package:either_dart/src/either.dart';
import 'package:musicy/core/errors/exception.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/music/data/datasources/local_music_data_source.dart';
import 'package:musicy/features/music/data/datasources/remote_music_data_source.dart';
import 'package:musicy/features/music/domain/entities/music.dart';
import 'package:musicy/features/music/domain/repositories/music_repository.dart';

import '../../../../core/network/network_info.dart';

class MusicRepositoryImpl implements MusicRepository {
  MusicRemoteDataSource musicRemoteDataSource;
  MusicLocalDataSource musicLocalDataSource;
  NetworkInfo networkInfo;

  MusicRepositoryImpl({
    required this.musicRemoteDataSource,
    required this.musicLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Music>> downloadMusic({
    required String videoId,
    required String name,
    required String author,
    required String defaultThumbnailUrl,
    required String mediumThumbnailUrl,
    required String highThumbnailUrl,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final music = await musicRemoteDataSource.downloadMusic(
          videoId: videoId,
          name: name,
          author: author,
          defaultThumbnailUrl: defaultThumbnailUrl,
          mediumThumbnailUrl: mediumThumbnailUrl,
          highThumbnailUrl: highThumbnailUrl,
        );
        await musicLocalDataSource.putMusic(music: music);
        return Right(music);
      } on MusicCancelException catch (error) {
        return Left(MusicCancelFailure(error.toString()));
      } on MusicConvertException catch (error) {
        return Left(MusicConvertFailure(error.toString()));
      }
    } else {
      return const Left(ServerFailure("No internet connection!"));
    }
  }

  @override
  Future<Either<Failure, List<Music>>> getAllMusics() async {
    try {
      final musics = await musicLocalDataSource.getAllMusics();
      return Right(musics);
    } catch (error) {
      return const Left(
          CacheFailure("Some problem occured relating the cache!"));
    }
  }
}

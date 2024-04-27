import 'package:either_dart/either.dart';
import 'package:musicy/core/errors/failure.dart';

import '../entities/music.dart';

abstract class MusicRepository {
  Future<Either<Failure, Music>> downloadMusic({
    required String videoId,
    required String name,
    required String author,
    required String defaultThumbnailUrl,
    required String mediumThumbnailUrl,
    required String highThumbnailUrl,
  });
  Future<Either<Failure, List<Music>>> getAllMusics();
  Future<Either<Failure, Null>> likeMusic({required String id});
  Future<Either<Failure, Null>> unlikeMusic({required String id});
  Future<Either<Failure, bool>> isMusicDownloaded({required String id});
}

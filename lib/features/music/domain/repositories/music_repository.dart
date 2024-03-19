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
}

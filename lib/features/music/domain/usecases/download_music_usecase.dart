import 'package:either_dart/either.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/music/domain/entities/download_music_inputs.dart';
import 'package:musicy/features/music/domain/entities/music.dart';
import 'package:musicy/features/music/domain/repositories/music_repository.dart';

import '../../../../core/usecases/usecase.dart';

class DownloadMusicUseCase implements UseCase<Music, DownloadMusicInputs> {
  final MusicRepository musicRepository;
  DownloadMusicUseCase({required this.musicRepository});

  @override
  Future<Either<Failure, Music>> call(DownloadMusicInputs params) {
    return musicRepository.downloadMusic(
      videoId: params.videoId,
      name: params.name,
      author: params.author,
      defaultThumbnailUrl: params.defaultThumbnailUrl,
      mediumThumbnailUrl: params.mediumThumbnailUrl,
      highThumbnailUrl: params.highThumbnailUrl,
    );
  }
}

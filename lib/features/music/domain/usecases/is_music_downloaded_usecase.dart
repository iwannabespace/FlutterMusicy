import 'package:either_dart/either.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/music/domain/repositories/music_repository.dart';

import '../../../../core/usecases/usecase.dart';

class IsMusicDownloaded implements UseCase {
  final MusicRepository musicRepository;
  IsMusicDownloaded({required this.musicRepository});

  @override
  Future<Either<Failure, bool>> call(id) {
    return musicRepository.isMusicDownloaded(id: id);
  }
}

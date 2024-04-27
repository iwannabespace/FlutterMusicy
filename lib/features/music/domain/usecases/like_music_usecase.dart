import 'package:either_dart/either.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/music/domain/repositories/music_repository.dart';

import '../../../../core/usecases/usecase.dart';

class LikeMusicUseCase implements UseCase {
  final MusicRepository musicRepository;
  LikeMusicUseCase({required this.musicRepository});

  @override
  Future<Either<Failure, Null>> call(id) {
    return musicRepository.likeMusic(id: id);
  }
}

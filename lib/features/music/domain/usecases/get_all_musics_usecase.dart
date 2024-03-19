import 'package:either_dart/either.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/music/domain/entities/music.dart';
import 'package:musicy/features/music/domain/repositories/music_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetAllMusicsUseCase implements UseCase {
  final MusicRepository musicRepository;
  GetAllMusicsUseCase({required this.musicRepository});

  @override
  Future<Either<Failure, List<Music>>> call(params) {
    return musicRepository.getAllMusics();
  }
}

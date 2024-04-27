import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/music/domain/entities/download_music_inputs.dart';
import 'package:musicy/features/music/domain/usecases/get_all_musics_usecase.dart';
import 'package:musicy/features/music/domain/usecases/is_music_downloaded_usecase.dart';
import 'package:musicy/features/music/domain/usecases/like_music_usecase.dart';
import 'package:musicy/features/music/domain/usecases/unlike_music_usecase.dart';

import '../../domain/entities/music.dart';
import '../../domain/usecases/download_music_usecase.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  DownloadMusicUseCase downloadMusicUseCase;
  GetAllMusicsUseCase getAllMusicsUseCase;
  LikeMusicUseCase likeMusicUseCase;
  UnlikeMusicUseCase unlikeMusicUseCase;
  IsMusicDownloaded musicDownloaded;
  MusicCubit(
      {required this.downloadMusicUseCase,
      required this.getAllMusicsUseCase,
      required this.likeMusicUseCase,
      required this.unlikeMusicUseCase,
      required this.musicDownloaded})
      : super(MusicInitial());

  Future<void> downloadMusic({required DownloadMusicInputs params}) async {
    emit(MusicDownloading());
    final musicOrNot = await downloadMusicUseCase(params);
    if (musicOrNot.isRight) {
      emit(MusicDownloaded());
    } else {
      final failure = musicOrNot.left;
      if (failure is MusicCancelFailure) {
        emit(MusicConversionCancelled(failure.message!));
      } else {
        emit(MusicConversionFailed(failure.message!));
      }
    }
  }

  Future<void> getAllMusics() async {
    emit(MusicsLoading());
    final musicsOrNot = await getAllMusicsUseCase(null);
    if (musicsOrNot.isRight) {
      emit(MusicsLoaded(musics: musicsOrNot.right));
    } else {
      emit(MusicError(musicsOrNot.left.message!));
    }
  }

  Future<void> likeMusic({required String id}) async {
    await likeMusicUseCase(id);
    final List<Music> musicsCopy = (state as MusicsLoaded).musics;
    emit(MusicsLoaded(musics: musicsCopy));
  }

  Future<void> unlikeMusic({required String id}) async {
    await unlikeMusicUseCase(id);
    final List<Music> musicsCopy = (state as MusicsLoaded).musics;
    emit(MusicsLoaded(musics: musicsCopy));
  }

  Future<bool> isMusicDownloaded({required String id}) async {
    final result = await musicDownloaded(id);
    return result.right;
  }
}

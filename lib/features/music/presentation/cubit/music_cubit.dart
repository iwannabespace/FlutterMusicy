import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/music/domain/entities/download_music_inputs.dart';
import 'package:musicy/features/music/domain/usecases/get_all_musics_usecase.dart';

import '../../domain/entities/music.dart';
import '../../domain/usecases/download_music_usecase.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  DownloadMusicUseCase downloadMusicUseCase;
  GetAllMusicsUseCase getAllMusicsUseCase;
  MusicCubit(
      {required this.downloadMusicUseCase, required this.getAllMusicsUseCase})
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
}

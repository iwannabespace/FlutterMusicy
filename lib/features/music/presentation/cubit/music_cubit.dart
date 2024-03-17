import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/music/domain/entities/download_music_inputs.dart';

import '../../domain/usecases/download_music_usecase.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  DownloadMusicUseCase downloadMusicUseCase;
  MusicCubit({required this.downloadMusicUseCase}) : super(MusicInitial());

  Future<void> downloadMusic({required DownloadMusicInputs params}) async {
    emit(MusicDownloading());
    final musicOrNot = await downloadMusicUseCase(params);
    print("Done2");

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
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musicy/features/youtube_search/domain/entities/youtube_search_result_entity.dart';
import 'package:musicy/features/youtube_search/domain/usecases/youtube_search_usecase.dart';

part 'youtube_search_state.dart';

class YoutubeSearchCubit extends Cubit<YoutubeSearchState> {
  YoutubeSearchUseCase youtubeSearchUseCase;

  YoutubeSearchCubit({required this.youtubeSearchUseCase})
      : super(YoutubeSearchInitial());

  Future<void> youtubeSearch({required String query}) async {
    if (query.isEmpty) {
      emit(YoutubeSearchInitial());
    } else {
      emit(YoutubeSearching());
      final resultOrNot = await youtubeSearchUseCase(query);
      if (resultOrNot.isRight) {
        emit(YoutubeSearched(youtubeSearchResult: resultOrNot.right));
      } else {
        emit(YoutubeSearchFailed(resultOrNot.left.message!));
      }
    }
  }
}

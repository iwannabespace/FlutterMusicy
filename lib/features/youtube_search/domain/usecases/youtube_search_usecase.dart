import 'package:either_dart/either.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/core/usecases/usecase.dart';
import 'package:musicy/features/youtube_search/domain/entities/youtube_search_result_entity.dart';

import '../repositories/youtube_search_repository.dart';

class YoutubeSearchUseCase implements UseCase<YoutubeSearchResult, String> {
  final YoutubeSearchRepository youtubeSearchRepository;
  YoutubeSearchUseCase({required this.youtubeSearchRepository});

  @override
  Future<Either<Failure, YoutubeSearchResult>> call(String query) {
    return youtubeSearchRepository.searchYoutube(query: query);
  }
}

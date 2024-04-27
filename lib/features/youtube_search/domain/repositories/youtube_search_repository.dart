import 'package:either_dart/either.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/youtube_search/domain/entities/youtube_search_result_entity.dart';

abstract class YoutubeSearchRepository {
  Future<Either<Failure, YoutubeSearchResult>> searchYoutube(
      {required String query});
}

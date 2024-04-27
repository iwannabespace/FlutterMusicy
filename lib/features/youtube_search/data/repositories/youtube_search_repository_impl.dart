import 'package:either_dart/src/either.dart';
import 'package:musicy/core/errors/exception.dart';
import 'package:musicy/core/errors/failure.dart';
import 'package:musicy/features/youtube_search/domain/entities/youtube_search_result_entity.dart';
import 'package:musicy/features/youtube_search/domain/repositories/youtube_search_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/remote_youtube_search_data_source.dart';

class YoutubeSearchRepositoryImpl implements YoutubeSearchRepository {
  final YoutubeSearchRemoteDataSource youtubeSearchRemoteDataSource;
  final NetworkInfo networkInfo;

  YoutubeSearchRepositoryImpl(
      {required this.youtubeSearchRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, YoutubeSearchResult>> searchYoutube(
      {required String query}) async {
    if (await networkInfo.isConnected) {
      try {
        final searchResult =
            await youtubeSearchRemoteDataSource.searchYoutube(query: query);
        return Right(searchResult);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.message));
      } on EnvironmentException catch (ex) {
        return Left(EnvironmentFailure(ex.message));
      }
    } else {
      return const Left(InternetFailure(""));
    }
  }
}

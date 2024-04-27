import 'package:dio/dio.dart';
import 'package:musicy/core/errors/exception.dart';
import 'package:musicy/core/functions/functions.dart';
import 'package:musicy/features/youtube_search/data/models/youtube_search_result_model.dart';

import '../../domain/entities/youtube_search_result_entity.dart';

abstract class YoutubeSearchRemoteDataSource {
  Future<YoutubeSearchResult> searchYoutube({required String query});
}

class YoutubeSearchRemoteDataSourceImpl
    implements YoutubeSearchRemoteDataSource {
  final Dio dio;

  YoutubeSearchRemoteDataSourceImpl({required this.dio});

  @override
  Future<YoutubeSearchResult> searchYoutube({required String query}) async {
    final adjustedUrl = getYoutubeSearchQuery(query: query);

    if (adjustedUrl != null) {
      final response = await dio.get(adjustedUrl);

      if (response.statusCode != 200) {
        throw ServerException(
            message:
                "Youtube search request failed with status code of ${response.statusCode}!");
      } else {
        return YoutubeSearchResultModel.fromJson(response.data);
      }
    } else {
      throw EnvironmentException(message: "API KEY couldn't be retrieved!");
    }
  }
}

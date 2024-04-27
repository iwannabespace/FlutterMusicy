import 'package:musicy/features/youtube_search/data/models/single_youtube_search_result_model.dart';
import 'package:musicy/features/youtube_search/domain/entities/youtube_search_result_entity.dart';

class YoutubeSearchResultModel extends YoutubeSearchResult {
  YoutubeSearchResultModel({required super.searchResults});

  factory YoutubeSearchResultModel.fromJson(Map<String, dynamic> json) {
    return YoutubeSearchResultModel(
        searchResults: (json['items'] as List)
            .map((e) => SingleYoutubeSearchResultModel.fromJson(e))
            .toList());
  }
}

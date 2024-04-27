import 'package:musicy/features/youtube_search/domain/entities/single_youtube_search_result.dart';

class SingleYoutubeSearchResultModel extends SingleYoutubeSearchResult {
  SingleYoutubeSearchResultModel({
    required super.id,
    required super.name,
    required super.author,
    required super.defaultThumbnailUrl,
    required super.mediumThumbnailUrl,
    required super.highThumbnailUrl,
  });

  factory SingleYoutubeSearchResultModel.fromJson(Map<String, dynamic> json) {
    final snippet = json["snippet"];

    return SingleYoutubeSearchResultModel(
      id: json["id"]["videoId"],
      name: snippet["title"],
      author: snippet["channelTitle"],
      defaultThumbnailUrl: snippet["thumbnails"]["default"]["url"],
      mediumThumbnailUrl: snippet["thumbnails"]["medium"]["url"],
      highThumbnailUrl: snippet["thumbnails"]["high"]["url"],
    );
  }
}

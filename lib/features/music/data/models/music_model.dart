import 'package:musicy/features/music/domain/entities/music.dart';

class MusicModel extends Music {
  MusicModel({
    required super.id,
    required super.name,
    required super.author,
    required super.defaultThumbnailUrl,
    required super.mediumThumbnailUrl,
    required super.highThumbnailUrl,
    required super.path,
    required super.liked,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json, String path) {
    final snippet = json["snippet"];
    return MusicModel(
      id: json["id"]["videoId"],
      name: snippet["title"],
      author: snippet["channelTitle"],
      defaultThumbnailUrl: snippet["thumbnails"]["default"]["url"],
      mediumThumbnailUrl: snippet["thumbnails"]["medium"]["url"],
      highThumbnailUrl: snippet["thumbnails"]["high"]["url"],
      path: path,
      liked: false,
    );
  }
}

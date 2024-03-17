import 'package:hive/hive.dart';

part 'music.g.dart';

@HiveType(typeId: 0)
class Music {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String author;
  @HiveField(3)
  final String defaultThumbnailUrl;
  @HiveField(4)
  final String mediumThumbnailUrl;
  @HiveField(5)
  final String highThumbnailUrl;

  Music({
    required this.id,
    required this.name,
    required this.author,
    required this.defaultThumbnailUrl,
    required this.mediumThumbnailUrl,
    required this.highThumbnailUrl,
  });
}

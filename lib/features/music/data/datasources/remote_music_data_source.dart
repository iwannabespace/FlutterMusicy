import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:musicy/core/errors/exception.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../domain/entities/music.dart';

abstract class MusicRemoteDataSource {
  Future<Music> downloadMusic(
      {required String videoId,
      required String name,
      required String author,
      required String defaultThumbnailUrl,
      required String mediumThumbnailUrl,
      required String highThumbnailUrl});
}

class MusicRemoteDataSourceImpl implements MusicRemoteDataSource {
  final Dio dio;
  MusicRemoteDataSourceImpl({required this.dio});

  @override
  Future<Music> downloadMusic(
      {required String videoId,
      required String name,
      required String author,
      required String defaultThumbnailUrl,
      required String mediumThumbnailUrl,
      required String highThumbnailUrl}) async {
    YoutubeExplode yt = YoutubeExplode();

    // Get video metadata.
    final video = await yt.videos.get(videoId);

    // Get the video manifest.
    final manifest = await yt.videos.streamsClient.getManifest(videoId);
    final streams = manifest.audioOnly;

    // Get the last audio track (the one with the highest bitrate).
    final audio = streams.withHighestBitrate();
    final audioStream = yt.videos.streamsClient.get(audio);

    // Compose the file name removing the unallowed characters in windows.
    final filename = '${video.title}.${audio.container.name.toString()}'
        .replaceAll('Container.', '')
        .replaceAll(r'\', '')
        .replaceAll('/', '')
        .replaceAll('*', '')
        .replaceAll('?', '')
        .replaceAll('"', '')
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('|', '');

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$filename';
    final file = File(path);

    // Open the file in appendMode.
    final output = file.openWrite(mode: FileMode.writeOnlyAppend);

    // Track the file download status.
    // final len = audio.size.totalBytes;
    // var count = 0;
    // var oldProgress = -1;

    await for (final data in audioStream) {
      // count += data.length;
      // final progress = ((count / len) * 100).round();

      // if (progress != oldProgress) {
      //   oldProgress = progress;
      // }
      output.add(data);
    }
    await output.close();

    final result =
        await FFmpegKit.execute('-i "$path" "${dir.path}/$name.wav"');
    final returnCode = await result.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      final file = File(path);
      file.deleteSync();

      return Music(
        id: videoId,
        name: name,
        author: author,
        defaultThumbnailUrl: defaultThumbnailUrl,
        mediumThumbnailUrl: mediumThumbnailUrl,
        highThumbnailUrl: highThumbnailUrl,
        path: "${dir.path}/$name.wav",
        liked: false,
      );
    } else if (ReturnCode.isCancel(returnCode)) {
      throw MusicCancelException(message: "Music convertion cancelled!");
    } else {
      throw MusicConvertException(message: "Music convertion failed!");
    }
  }
}

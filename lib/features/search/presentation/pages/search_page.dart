import 'dart:io';

import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    bool isPlaying = false;
    return Column(
      children: [
        FilledButton(
          onPressed: () async {},
          child: Text("Download"),
        ),
        FilledButton(
          onPressed: () async {
            final dir = await getApplicationDocumentsDirectory();
            if (!isPlaying) {
              await player.setFilePath('${dir.path}/deneme.wav');
              player.play();
              isPlaying = true;
            }
            print(player.playing);
          },
          child: Text("Play"),
        ),
        FilledButton(
          onPressed: () async {
            if (isPlaying) {
              await player.pause();
              isPlaying = false;
            }
          },
          child: Text("Stop"),
        ),
        FilledButton(
          onPressed: () async {
            final dir = await getApplicationDocumentsDirectory();
            FFmpegKit.executeAsync(
                '-i ${dir.path}/annen.webm ${dir.path}/deneme.wav',
                (session) async {
              final returnCode = await session.getReturnCode();

              if (ReturnCode.isSuccess(returnCode)) {
                print("Success");
              } else if (ReturnCode.isCancel(returnCode)) {
                print("Cancel");
              } else {
                print(returnCode);
              }
            });
          },
          child: Text("Convert"),
        ),
      ],
    );
  }
}

// Future<String> getLink(String id) async {
//   var _yt = YoutubeExplode();
//   var _manifest = await _yt.videos.streamsClient.getManifest(id);
//   return _manifest.audioOnly.withHighestBitrate().url.toString();
// }
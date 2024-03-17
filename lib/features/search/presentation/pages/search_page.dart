import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: () async {
            final link = await getLink("mY--4-vzY6E");
            print(link);
          },
          child: Text("Download"),
        ),
      ],
    );
  }
}

Future<String> getLink(String id) async {
  var _yt = YoutubeExplode();
  var _manifest = await _yt.videos.streamsClient.getManifest(id);
  return Platform.isIOS
      ? _manifest.audioOnly.withHighestBitrate().url.toString()
      : _manifest.audioOnly.withHighestBitrate().url.toString();
}

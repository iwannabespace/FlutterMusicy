import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:musicy/core/classes/player.dart';

import '../../features/music/domain/entities/music.dart';

class SongCard extends StatelessWidget {
  final Music music;
  const SongCard({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    final musicPlayer = GetIt.instance<GlobalMusicPlayer>();
    return InkWell(
      onTap: () async {
        if (musicPlayer.file.isEmpty) {
          await musicPlayer.setFile(file: music.path);
          await musicPlayer.play();
        } else {
          if (musicPlayer.file == music.path) {
            if (musicPlayer.player.playing) {
              await musicPlayer.pause();
            } else {
              await musicPlayer.play();
            }
          } else {
            await musicPlayer.setFile(file: music.path);
            await musicPlayer.play();
          }
        }
      },
      splashColor: null,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 16, 16, 16),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    music.defaultThumbnailUrl,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: music.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                    TextSpan(
                      text: music.author,
                      style: const TextStyle(
                        color: Colors.white60,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () async {},
              icon: const Icon(
                Icons.favorite_border,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

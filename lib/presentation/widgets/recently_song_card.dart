import 'package:flutter/material.dart';

import '../../features/music/domain/entities/music.dart';

class RecentlySongCard extends StatelessWidget {
  const RecentlySongCard({super.key, required this.music});
  final Music music;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 6, top: 16, bottom: 16),
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
                  image: NetworkImage(music.defaultThumbnailUrl),
                ),
              ),
            ),
            const SizedBox(width: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: music.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: music.author,
                    style: const TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

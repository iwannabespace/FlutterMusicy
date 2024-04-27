import 'package:flutter/material.dart';

import '../../features/music/domain/entities/music.dart';

class DailySongCard extends StatelessWidget {
  const DailySongCard({super.key, required this.music});
  final Music music;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(22),
        ),
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(music.mediumThumbnailUrl),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 4,
            ),
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Text(
              music.name,
              style: const TextStyle(
                color: Colors.yellow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

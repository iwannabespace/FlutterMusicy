import 'package:flutter/material.dart';
import 'package:musicy/features/music/domain/entities/music.dart';

class MusicItem extends StatelessWidget {
  const MusicItem({super.key, required this.music});
  final Music music;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(music.defaultThumbnailUrl),
                fit: BoxFit.contain),
          ),
        ),
        Text(music.name),
      ],
    );
  }
}

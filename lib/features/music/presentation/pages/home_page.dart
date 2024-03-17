import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicy/features/music/domain/entities/download_music_inputs.dart';
import 'package:musicy/features/music/presentation/cubit/music_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (context, state) {
        print(state.toString());
        return Column(
          children: [
            FilledButton(
              onPressed: () async {
                await context.read<MusicCubit>().downloadMusic(
                    params: DownloadMusicInputs(
                        videoId: "8IntJlMRwnc",
                        name: "J.S. Bach - Prelude in C Major",
                        author: "Rousseau",
                        defaultThumbnailUrl:
                            "https://i.ytimg.com/vi/frxT2qB1POQ/default.jpg",
                        mediumThumbnailUrl:
                            "https://i.ytimg.com/vi/frxT2qB1POQ/mqdefault.jpg",
                        highThumbnailUrl:
                            "https://i.ytimg.com/vi/frxT2qB1POQ/hqdefault.jpg"));
              },
              child: const Text("Download"),
            ),
            if (state is MusicDownloading) const CircularProgressIndicator()
          ],
        );
      },
    );
  }
}

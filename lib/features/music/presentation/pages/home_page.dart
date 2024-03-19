import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicy/features/music/domain/entities/download_music_inputs.dart';
import 'package:musicy/features/music/presentation/cubit/music_cubit.dart';
import 'package:musicy/features/music/presentation/widgets/music_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (context, state) {
        if (state is MusicsLoaded) {
          return ListView.builder(
            itemCount: state.musics.length,
            itemBuilder: (context, index) {
              return MusicItem(music: state.musics[index]);
            },
          );
        } else {
          return Text("No music available");
        }
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicy/features/music/presentation/cubit/music_cubit.dart';

import '../widgets/song_card.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 160, 50, 50),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 160, 50, 50),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Müziklerim",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<MusicCubit, MusicState>(
        builder: (context, state) {
          if (state is MusicsLoaded && state.musics.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 16, 16, 16),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: const TextField(
                      cursorColor: Colors.white,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        hintText: "Müzik ara",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          height: 0,
                          fontSize: 12,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.musics.length,
                    itemBuilder: (context, index) {
                      return SongCard(music: state.musics[index]);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: FittedBox(
                child: Text(
                  "İndirilmiş müzik bulunamadı!",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

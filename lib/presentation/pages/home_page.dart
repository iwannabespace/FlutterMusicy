import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicy/features/music/presentation/cubit/music_cubit.dart';

import '../widgets/daily_song_card.dart';
import '../widgets/recently_song_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 160, 50, 50),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 160, 50, 50),
        elevation: 0,
        centerTitle: false,
        title: isSearch
            ? const SizedBox()
            : const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  "Merhaba Seher",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
        actions: [
          AnimatedContainer(
            width: isSearch ? MediaQuery.of(context).size.width - 48 : 60,
            margin: EdgeInsets.only(
              left: isSearch ? 24 : 0,
              right: isSearch ? 24 : 15,
            ),
            duration: const Duration(milliseconds: 300),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 16, 16, 16),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: !isSearch
                ? IconButton(
                    onPressed: () {
                      isSearch = !isSearch;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  )
                : TextField(
                    autofocus: isSearch,
                    cursorColor: Colors.white,
                    maxLines: 1,
                    onTapOutside: (event) {
                      isSearch = !isSearch;
                      setState(() {});
                    },
                    onSubmitted: (value) {
                      if (value.isEmpty) {
                        isSearch = !isSearch;
                      }
                      setState(() {});
                    },
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    decoration: const InputDecoration(
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: const EdgeInsets.only(left: 24, top: 12),
                height: 275,
                width: 932,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 16, 16, 16),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(26), right: Radius.circular(26)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 12,
                        left: 24,
                      ),
                      child: Text(
                        "Günün Şarkıları",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: BlocBuilder<MusicCubit, MusicState>(
                          builder: (context, state) {
                            if (state is MusicsLoaded) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.musics.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return DailySongCard(
                                    music: (state.musics[index]),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 16, 16, 16),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 14),
                      child: Text(
                        "Son Çalınan Şarkılar",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    BlocBuilder<MusicCubit, MusicState>(
                      builder: (context, state) {
                        if (state is MusicsLoaded) {
                          return Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.musics.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return RecentlySongCard(
                                    music: state.musics[index]);
                              },
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

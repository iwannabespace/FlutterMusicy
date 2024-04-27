import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicy/features/music/domain/entities/download_music_inputs.dart';

import 'package:musicy/features/music/presentation/cubit/music_cubit.dart';

import 'package:musicy/features/youtube_search/domain/entities/single_youtube_search_result.dart';

class SearchSongCard extends StatefulWidget {
  const SearchSongCard({super.key, required this.searchResult});
  final SingleYoutubeSearchResult searchResult;

  @override
  State<SearchSongCard> createState() => _SearchSongCardState();
}

class _SearchSongCardState extends State<SearchSongCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        isSelected = !isSelected;
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isSelected ? 500 : 250,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 16, 16, 16),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSelected ? 350 : 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.searchResult.mediumThumbnailUrl),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.searchResult.author,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.searchResult.name,
                            maxLines: 3,
                            style: const TextStyle(
                              color: Colors.white60,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<MusicCubit, MusicState>(
                    builder: (context, state) {
                      return FilledButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        onPressed: () async {
                          if (state is! MusicDownloading) {
                            final downloaded = await context
                                .read<MusicCubit>()
                                .isMusicDownloaded(id: widget.searchResult.id);

                            if (context.mounted) {
                              if (!downloaded) {
                                context.read<MusicCubit>().downloadMusic(
                                      params: DownloadMusicInputs(
                                        videoId: widget.searchResult.id,
                                        name: widget.searchResult.name,
                                        author: widget.searchResult.author,
                                        defaultThumbnailUrl: widget
                                            .searchResult.defaultThumbnailUrl,
                                        mediumThumbnailUrl: widget
                                            .searchResult.mediumThumbnailUrl,
                                        highThumbnailUrl: widget
                                            .searchResult.highThumbnailUrl,
                                      ),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Bu müzik zaten indirilmiş!"),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        child: state is MusicDownloading
                            ? const CircularProgressIndicator()
                            : const Icon(Icons.download,
                                color: Colors.white, size: 26),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

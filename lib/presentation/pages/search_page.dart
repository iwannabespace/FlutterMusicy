import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicy/features/youtube_search/presentation/cubit/youtube_search_cubit.dart';

import '../widgets/search_song_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 160, 50, 50),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 160, 50, 50),
        centerTitle: true,
        title: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 16, 16, 16),
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: TextField(
            cursorColor: Colors.white,
            maxLines: 1,
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
            onSubmitted: (value) async {
              await BlocProvider.of<YoutubeSearchCubit>(context)
                  .youtubeSearch(query: value);
            },
          ),
        ),
      ),
      body: BlocBuilder<YoutubeSearchCubit, YoutubeSearchState>(
        builder: (context, state) {
          if (state is YoutubeSearched) {
            return ListView.builder(
              itemCount: state.youtubeSearchResult.searchResults.length,
              itemBuilder: (context, index) {
                return SearchSongCard(
                  searchResult: state.youtubeSearchResult.searchResults[index],
                );
              },
            );
          } else if (state is YoutubeSearchInitial) {
            return const Center(
              child: FittedBox(
                child: Text(
                  "Müzik ara Seher hanım",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

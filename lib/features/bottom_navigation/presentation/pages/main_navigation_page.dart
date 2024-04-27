import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicy/features/music/presentation/cubit/music_cubit.dart';

import 'package:musicy/presentation/pages/home_page.dart';
import 'package:musicy/presentation/pages/library_page.dart';
import 'package:musicy/presentation/pages/search_page.dart';

import '../cubit/bottom_navigation_cubit.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, index) => BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 16, 16, 16),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          iconSize: 20,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          onTap: (value) {
            context.read<BottomNavigationCubit>().navigateTo(value);
          },
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.house,
              ),
              label: "Ana sayfa",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
              ),
              label: "Ara",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.book,
              ),
              label: "Kitaplığım",
            ),
          ],
        ),
      ),
      body: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, page) {
          if (page == 0) {
            BlocProvider.of<MusicCubit>(context).getAllMusics();
            return const HomePage();
          } else if (page == 1) {
            return const SearchPage();
          } else {
            BlocProvider.of<MusicCubit>(context).getAllMusics();
            return const LibraryPage();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicy/features/search/presentation/pages/search_page.dart';

import '../cubit/bottom_navigation_cubit.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "MUSICY",
          style: TextStyle(),
        ),
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, index) => BottomNavigationBar(
          selectedLabelStyle: const TextStyle(),
          unselectedLabelStyle: const TextStyle(),
          onTap: (value) {
            context.read<BottomNavigationCubit>().navigateTo(value);
          },
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.house,
              ),
              label: "Anasayfa",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
              ),
              label: "Arama",
            ),
          ],
        ),
      ),
      body: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          if (state == 0) {
            return Text("Home");
          } else {
            return SearchPage();
          }
        },
      ),
    );
  }
}

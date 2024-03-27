import 'dart:ui';

import 'package:f2p_games/view/pages/game/games_list_page.dart';
import 'package:f2p_games/view/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

import '../game/saved_games_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: [
          GamesListPage(),
          SavedPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20.0,
            sigmaY: 20.0,
          ),
          child: BottomAppBar(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: BottomNavigationBar(
                currentIndex: paginaAtual,
                selectedItemColor: Colors.greenAccent,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark_outline), label: 'Wishlist'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_outlined), label: 'Profile'),
                ],
                onTap: (pagina) {
                  pc.animateToPage(
                    pagina,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

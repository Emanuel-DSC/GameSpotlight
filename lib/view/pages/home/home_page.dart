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
        children: const [
          GamesListPage(),
          SavedPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 300.0,
              sigmaY: 300.0,
            ),
          child: BottomAppBar(
            color: Colors.transparent, 
            elevation: 0,
            child: BottomNavigationBar(
              currentIndex: paginaAtual,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Wishlist'),
                BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Profile'),
              ],
              onTap: (pagina) {
                pc.animateToPage(pagina,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease);
              },
              backgroundColor: Colors.transparent, 
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}

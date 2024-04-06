
import 'package:f2p_games/view/pages/game/games_list_page.dart';
import 'package:f2p_games/view/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_bottom_nav_bar_widget.dart';
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
      bottomNavigationBar: MyBottomNavBar(paginaAtual: paginaAtual, pc: pc),
    );
  }
}


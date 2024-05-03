import 'package:f2p_games/view/pages/game/games_list_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_bottom_nav_bar_widget.dart';
import '../favourite/saved_games_page.dart';
import '../setting/setting_page.dart';

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
        physics: const NeverScrollableScrollPhysics(),
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          GamesListPage(),
          FavouritesPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(paginaAtual: paginaAtual, pc: pc),
    );
  }
}

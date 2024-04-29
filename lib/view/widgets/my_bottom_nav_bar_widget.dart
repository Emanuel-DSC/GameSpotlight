import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:f2p_games/constants/colors.dart';
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key? key,
    required this.paginaAtual,
    required this.pc,
  }) : super(key: key);

  final int paginaAtual;
  final PageController pc;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
              selectedItemColor: kButtonColor1,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(EvaIcons.homeOutline),
                  activeIcon: Icon(EvaIcons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(EvaIcons.bookmarkOutline),
                  activeIcon: Icon(EvaIcons.bookmark),
                  label: 'Wishlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(EvaIcons.personOutline),
                  activeIcon: Icon(EvaIcons.person),
                  label: 'Profile',
                ),
              ],
              onTap: (pagina) {
                pc.animateToPage(
                  pagina,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
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

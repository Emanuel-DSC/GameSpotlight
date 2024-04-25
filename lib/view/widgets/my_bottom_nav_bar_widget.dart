import 'dart:ui';

import 'package:f2p_games/constants/colors.dart';
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    super.key,
    required this.paginaAtual,
    required this.pc,
  });

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
    );
  }
}

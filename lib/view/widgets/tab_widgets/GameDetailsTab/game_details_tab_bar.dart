import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameDetailsTabBar extends StatelessWidget {
  final bool isScrollable;
  final Color onColor;
  final Color offColor;
  final String firstTitle;
  final String secondTitle;

  const GameDetailsTabBar({
    super.key,
    required this.isScrollable,
    required this.onColor,
    required this.offColor,
    required this.firstTitle,
    required this.secondTitle,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: isScrollable,
        labelColor: onColor,
        unselectedLabelColor: offColor,
        indicatorWeight: 0,
        indicator: const UnderlineTabIndicator(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          insets: EdgeInsets.symmetric(horizontal: 10.0),
        ),
        tabs: [
          Tab(
              child: Text(
            firstTitle,
            style: GoogleFonts.roboto(fontSize: 14),
          )),
          Tab(
              child: Text(
            secondTitle,
            style: GoogleFonts.roboto(fontSize: 14),
          )),
        ]);
  }
}

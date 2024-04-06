import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';

class GameDetailsTabBar extends StatelessWidget {
  final String firstTitle;
  final String secondTitle;

  const GameDetailsTabBar({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: true,
        labelColor: Colors.white,
        indicatorPadding: EdgeInsets.zero,
        unselectedLabelColor: Colors.grey.shade600,
        indicatorColor: kButtonColor1,
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

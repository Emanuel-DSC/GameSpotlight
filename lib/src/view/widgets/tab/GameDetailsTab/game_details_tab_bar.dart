import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/colors.dart';

class GameDetailsTabBar extends StatelessWidget {
  final String firstTitle;
  final String secondTitle;
  final String thitrdTitle;

  const GameDetailsTabBar({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    required this.thitrdTitle,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelColor: Colors.white,
        indicatorPadding: EdgeInsets.zero,
        unselectedLabelColor: Colors.grey.shade600,
        indicatorColor: kButtonColor1,
        dividerHeight: 0,
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
          Tab(
              child: Text(
            thitrdTitle,
            style: GoogleFonts.roboto(fontSize: 14),
          )),
        ]);
  }
}

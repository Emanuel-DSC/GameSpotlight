import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';

class GamesListTabBar extends StatelessWidget {
  const GamesListTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.only(right: 20),
        indicatorColor: kButtonColor1,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,
        tabs: [
          Tab(
            child: Text(
              'Popular',
              style: GoogleFonts.michroma(
                textStyle: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          Tab(
            child: Text(
              'Newest',
              style: GoogleFonts.michroma(
                textStyle: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          Tab(
            child: Text(
              'Alphabetical',
              style: GoogleFonts.michroma(
                textStyle: const TextStyle(fontSize: 12),
              ),
            ),
          )
        ]);
  }
}

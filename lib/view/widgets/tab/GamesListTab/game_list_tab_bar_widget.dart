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
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelColor: Colors.white,
        indicatorPadding: EdgeInsets.zero,
        unselectedLabelColor: Colors.grey.shade600,
        indicatorColor: kButtonColor1,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.only(right: 20),
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

import 'package:f2p_games/view/widgets/text/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../data/repositories/games_store.dart';
import '../../services/search_bar_services.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.store,
  });

  final GameStore store;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(store),
        );
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: kSearchBarColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kCardColor),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
              SizedBox(width: 10),
              MyText(
                googleFont: GoogleFonts.roboto,
                color: Colors.grey,
                fontSize: 14,
                title: 'Search free game',
                weight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

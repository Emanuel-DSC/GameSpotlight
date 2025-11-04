import 'package:f2p_games/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/repositories/games_store_controller.dart';
import '../../pages/game/categories/all_categories_page.dart';
import 'my_text.widget.dart';

class CategoriesTextAndAnimation extends StatelessWidget {
  final GameStore store;

  const CategoriesTextAndAnimation({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const MyText(
            googleFont: GoogleFonts.michroma,
            color: Colors.white,
            fontSize: 14,
            title: 'Categories',
            weight: FontWeight.bold,
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllCategoriesPage(store: store),
                ),
              );
            },
            child: Row(
              children: [
                MyText(googleFont: GoogleFonts.poppins, color: Colors.white,
                fontSize: 14, title: 'see all'.toUpperCase(), weight: FontWeight.bold),
                LottieBuilder.asset(
                  animationPathSwipe,
                  height: 30,
                  width: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

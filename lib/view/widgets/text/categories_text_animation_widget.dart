import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'my_text.widget.dart';

class CategoriesTextAndAnimation extends StatelessWidget {
  const CategoriesTextAndAnimation({
    super.key,
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
          LottieBuilder.asset('lib/src/assets/animation/swipe.json', 
          height: 30, width: 30,),
        ],
      ),
    );
  }
}
import 'dart:ui';

import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBlurredBg extends StatelessWidget {
  const TextBlurredBg({
    super.key,
    required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15,
            sigmaY: 15,
          ),
          child: IntrinsicWidth(
            child: Container(
              constraints: const BoxConstraints(minWidth: 60),
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: MyText(
                color: Colors.white,
                fontSize: 14,
                googleFont: GoogleFonts.roboto,
                title: item.toUpperCase(),
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

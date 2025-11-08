import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'my_text.widget.dart';

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
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: IntrinsicWidth(
            child: Container(
              constraints: const BoxConstraints(minWidth: 60),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: GradientBoxBorder(
                  gradient: LinearGradient(colors: [Colors.grey.shade100.withValues(alpha: .10), Colors.white.withValues(alpha: .25)]),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
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

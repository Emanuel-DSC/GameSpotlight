import 'package:f2p_games/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/colors.dart';
import '../text/my_text.widget.dart';

class MyButton extends StatelessWidget {
  final VoidCallback launchUrl;
  const MyButton({
    super.key,
    required this.launchUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kButtonColor1, kButtonColor2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: const [0.3, 0.7],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: kButtonColor1.withValues(alpha: .5),
            spreadRadius: 0.05,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          launchUrl();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyText(
                googleFont: GoogleFonts.roboto,
                color: Colors.white,
                fontSize: 16.0,
                title: 'Play Now',
                weight: FontWeight.bold),
            LottieBuilder.asset(
              animationPathDownload,
              height: 50,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}

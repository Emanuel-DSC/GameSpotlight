import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../my_text.widget.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool iconDisplay;
  final Color textColor;
  final Color bgColor;
  const LoginButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.iconDisplay,
    required this.textColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            );
          }),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              googleFont: GoogleFonts.lato,
              color: textColor,
              fontSize: 14,
              title: title.toUpperCase(),
              weight: FontWeight.normal,
            ),
            Visibility(
              visible: iconDisplay,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    EvaIcons.google,
                    color: Colors.grey.shade600,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

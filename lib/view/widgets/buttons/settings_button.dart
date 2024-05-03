import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../text/my_text.widget.dart';

class SettingsButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String text;
  final IconData icon;
  const SettingsButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.text, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
              googleFont: GoogleFonts.lato,
              color: color,
              fontSize: 18,
              title: text,
              weight: FontWeight.normal),
          const SizedBox(width: 5),
          Icon(
            icon,
            color: color,
          ),
        ],
      ),
      onTap: () {
        onTap;
      },
    );
  }
}

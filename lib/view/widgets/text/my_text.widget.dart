import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final Function googleFont;
  final Color color;
  final double fontSize;
  final String title;
  final FontWeight weight;

  const MyText({
    super.key,
    required this.googleFont,
    required this.color,
    required this.fontSize,
    required this.title, 
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: googleFont(
        fontWeight: weight,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}

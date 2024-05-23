import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final Function googleFont;
  final Color color;
  final double fontSize;
  final String title;
  final FontWeight weight;
  final TextAlign? align;
  final TextOverflow? overflow;

  const MyText({
    super.key,
    required this.googleFont,
    required this.color,
    required this.fontSize,
    required this.title,
    required this.weight,
    this.align,
    this.overflow, 
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      overflow: overflow, 
      style: googleFont(
        fontWeight: weight,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}

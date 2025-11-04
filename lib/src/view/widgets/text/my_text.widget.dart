import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final Function googleFont;
  final Color color;
  final double fontSize;
  final String title;
  final FontWeight weight;
  final TextAlign? align;
  final TextOverflow? overflow;
  final int? maxLines;

  const MyText({
    super.key,
    required this.googleFont,
    required this.color,
    required this.fontSize,
    required this.title,
    required this.weight,
    this.align,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      style: googleFont(
        fontWeight: weight,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}

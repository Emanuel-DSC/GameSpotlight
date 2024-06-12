import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData appBarThemeData() {
    return ThemeData(
    scaffoldBackgroundColor: kBgColor1,
    textTheme: TextTheme(
      // Use this to change the query's text style
      titleLarge: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 18,
      ),
      titleMedium: GoogleFonts.michroma(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kBgColor1,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: GoogleFonts.roboto(color: Colors.grey, fontSize: 16),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kButtonColor1,
    ),
  );
  }
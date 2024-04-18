import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/widgets/my_progress_indicador_widget.dart';
import '../view/widgets/text/my_text.widget.dart';

class GameListPageServices {
  Widget buildLoadingIndicator() {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 50.0,
          sigmaY: 50.0,
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          child: const MyCircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildErrorText(String error) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
            color: Colors.grey,
            fontSize: 28,
            googleFont: GoogleFonts.lato,
            title: 'Sorry, something went wrong'.toUpperCase(),
            weight: FontWeight.normal,
          ),
            const SizedBox(height: 10,),
            Text(
              error,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyListText() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyCircularProgressIndicator(),
          SizedBox(height: 20),
          MyText(
            color: Colors.grey,
            fontSize: 24,
            googleFont: GoogleFonts.lato,
            title: 'Loading games',
            weight: FontWeight.normal,
          ),
        ],
      ),
    );
  }
}

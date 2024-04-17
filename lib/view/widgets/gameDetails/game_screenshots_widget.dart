import 'dart:ui';

import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../text/my_text.widget.dart';

class GameScreenshots extends StatelessWidget {
  const GameScreenshots({
    Key? key,
    required this.screenshots,
  }) : super(key: key);

  final List<String> screenshots;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 170,
      width: double.infinity,
      child: screenshots.isEmpty
          ? const Center(
              child: Text(
                'No screenshots available',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: screenshots.length,
              itemBuilder: (context, index) {
                final screenshotUrl = screenshots[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.network(
                      screenshotUrl,
                      height: 60,
                      width: 300,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: MyCircularProgressIndicator()),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 300,
                                  sigmaY: 300,
                                ),
                                child: Container(
                                    height: 60,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(16),
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(colors: [
                                          Colors.grey.shade100
                                              .withOpacity(0.10),
                                          Colors.white.withOpacity(0.25)
                                        ]),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error_outline_rounded, color: Colors.grey, size: 30),
                                        SizedBox(height: 10),
                                        MyText(
                                            googleFont: GoogleFonts.roboto,
                                            color: Colors.white,
                                            fontSize: 18,
                                            title: 'Impossible to load image',
                                            weight: FontWeight.normal)
                                      ],
                                    )))));
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

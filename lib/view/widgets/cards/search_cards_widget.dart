import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/games_models.dart';
import '../my_progress_indicador_widget.dart';
import '../text/my_text.widget.dart';

class GameCardList extends StatelessWidget {
  final GameModel item;
  final VoidCallback onTap;
  final BoxFit fit;
  const GameCardList({
    Key? key,
    required this.item,
    required this.onTap,
    required this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 105,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: item.thumbnail ?? 'Not found',
                  fit: fit,
                  placeholder: (context, url) => Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: const MyCircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),

          // Container with description
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 150.0,
                  sigmaY: 150.0,
                ),
                child: Container(
                  height: 105,
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              googleFont: GoogleFonts.zenDots,
                              color: Colors.white,
                              fontSize: 12.0,
                              title: item.title ?? 'Title not available',
                              weight: FontWeight.normal),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                  googleFont: GoogleFonts.michroma,
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                  title: item.genre ?? 'Genre not available',
                                  weight: FontWeight.bold),
                              TextButton(
                                  onPressed: onTap,
                                  child: const MyText(
                                      googleFont: GoogleFonts.roboto,
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      title: 'Learn More',
                                      weight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

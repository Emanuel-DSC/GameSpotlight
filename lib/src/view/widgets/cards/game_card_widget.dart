import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors.dart';
import '../../../models/game_model.dart';
import '../my_progress_indicador_widget.dart';
import '../text/my_text.widget.dart';

class GameCard extends StatelessWidget {
  final GameModel item;
  final VoidCallback onTap;
  final BoxFit fit;
  final int imageFlexValue;
  final int containerFlexValue;
  final double padding;
  final double heightSize;
  const GameCard({
    Key? key,
    required this.item,
    required this.onTap,
    required this.fit,
    required this.imageFlexValue,
    required this.containerFlexValue,
    required this.padding,
    required this.heightSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: imageFlexValue,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: item.thumbnail ?? 'Not found',
                  fit: fit,
                  placeholder: (context, url) => Container(
                    color: Colors.white.withOpacity(0.2),
                    alignment: Alignment.center,
                    child: const MyCircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            // Container with description
            Expanded(
              flex: containerFlexValue,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              googleFont: GoogleFonts.zenDots,
                              color: Colors.white,
                              fontSize: 14.0,
                              title: item.title ?? 'Title not available',
                              weight: FontWeight.normal),
                           SizedBox(height: heightSize),
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
                                      fontSize: 14.0,
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
          ],
        ),
      ),
    );
  }
}

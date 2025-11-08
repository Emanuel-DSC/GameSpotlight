import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/dominant_color_service.dart';
import '../../../models/game_model.dart';
import '../my_progress_indicador_widget.dart';
import '../my_shimmer.dart';
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
    super.key,
    required this.item,
    required this.onTap,
    required this.fit,
    required this.imageFlexValue,
    required this.containerFlexValue,
    required this.padding,
    required this.heightSize,
  });

  //Helper function to combine the asynchronous tasks.
  Future<Color> _loadCardData(String imageUrl, BuildContext context) async {
    if (imageUrl.isEmpty) {
      // Return a default color immediately if no image exists
      return Colors.red;
    }

    //Get the dominant color
    final colorFuture = DominantColorService.getColor(imageUrl);
    final precacheFuture = precacheImage(
      CachedNetworkImageProvider(imageUrl),
      context,
    );
    final results = await Future.wait([colorFuture, precacheFuture]);
    return results[0] as Color;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.thumbnail ?? '';

    return FutureBuilder<Color>(
      future: _loadCardData(imageUrl, context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // Shimmer runs until BOTH the color and image are ready
          return MyShimmer(imageFlexValue: imageFlexValue, containerFlexValue: containerFlexValue, padding: padding, heightSize: heightSize);
        }

        // Card when data is ready (color and precached image)
        final bgColor = snapshot.data!;
        final textColor = ColorUtils.getTextColor(bgColor);

        return InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Card(
              elevation: 0,
              color: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: imageFlexValue,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: fit,
                        placeholder: (_, __) => Container(
                          color: kCardColor.withValues(alpha: .8),
                          alignment: Alignment.center,
                          child: const MyCircularProgressIndicator(),
                        ),
                        errorWidget: (_, __, ___) => const Icon(Icons.error),
                      ),
                    ),
                    Expanded(
                      flex: containerFlexValue,
                      child: ClipRect(
                        child: Stack(
                          children: [
                            Container(color: bgColor),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                              child: Container(
                                color: Colors.black.withValues(alpha: .12),
                                foregroundDecoration: BoxDecoration(
                                  color: bgColor.withValues(alpha: .12),
                                  backgroundBlendMode: BlendMode.softLight,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    googleFont: GoogleFonts.zenDots,
                                    color: textColor,
                                    fontSize: 14.0,
                                    title: item.title ?? 'Title unavailable',
                                    weight: FontWeight.normal,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: heightSize),
                                  MyText(
                                    googleFont: GoogleFonts.basic,
                                    color: textColor.withValues(alpha: .85),
                                    fontSize: 12.0,
                                    title: item.shortDescription ?? '',
                                    weight: FontWeight.w200,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../my_shimmer.dart';
import '../text/my_text.widget.dart';

class GridCategoriesCards extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final double padding;
  final double heightSize;

  const GridCategoriesCards({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
    required this.padding,
    required this.heightSize,
  });

  // Function to initiate pre-caching (can stay here, or be defined as a local function)
  Future<void> _preloadImage(BuildContext context) async {
    if (imageUrl.isEmpty) return;

    await precacheImage(
      CachedNetworkImageProvider(imageUrl),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the desired size for the grid item
    final double cardWidth = (MediaQuery.sizeOf(context).width / 2) - 20;
    const double cardHeight = 140;

    return FutureBuilder<void>(
      future: _preloadImage(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            height: cardHeight,
            width: cardWidth,
            child: MyShimmer(
              height: cardHeight,
              width: cardWidth,
              padding: padding,
              heightSize: heightSize,
            ),
          );
        }

        //Return the complete UI when the image is ready
        return SizedBox(
          height: cardHeight,
          width: cardWidth,
          child: GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 250),
                      memCacheWidth: 300,
                      placeholder: (_, __) => Container(color: Colors.transparent),
                      errorWidget: (_, __, ___) => Container(
                        color: Colors.black26,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image, color: Colors.white54),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .1),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                          ),
                          child: Center(
                            child: MyText(
                              googleFont: GoogleFonts.poppins,
                              color: Colors.white,
                              fontSize: 14,
                              title: title.toUpperCase(),
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

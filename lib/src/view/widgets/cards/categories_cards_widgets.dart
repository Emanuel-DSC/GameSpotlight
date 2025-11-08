import 'dart:ui';
import 'package:f2p_games/src/view/widgets/my_progress_indicador_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../text/my_text.widget.dart';

class GridCategoriesCards extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const GridCategoriesCards({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                placeholder: (_, __) => Container(
                  color: Colors.black26,
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 35,
                    height: 35,
                    child: MyCircularProgressIndicator()
                  ),
                ),
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
    );
  }
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../my_progress_indicador_widget.dart';
import '../text_blur_bg_widget.dart';

class CategoriesCards extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String item;

  const CategoriesCards({
    Key? key,
    required this.item,
    required this.onTap,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.white.withOpacity(0.2),
                alignment: Alignment.center,
                child: const MyCircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Blurred bg on text
                    TextBlurredBg(item: item),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



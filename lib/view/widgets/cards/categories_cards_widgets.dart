import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
            borderRadius:
                BorderRadius.circular(16), // Apply border radius to the image
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Apply blur effect
          ClipRRect(
            borderRadius:
                BorderRadius.circular(16), // Apply the same border radius
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Centered text
          Center(
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

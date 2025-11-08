import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CyberpunkShimmerCard extends StatelessWidget {
  final double width;
  final double height;

  const CyberpunkShimmerCard({
    super.key,
    this.width = 180,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    // cores base
    const baseColor = Color(0xff1A1425);       // dark purple base
    const highlightColor = Color(0xff8A2BE2);  // electric neon purple

    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 0),
      color: highlightColor,
      colorOpacity: 0.9,
      direction: const ShimmerDirection.fromLeftToRight(),
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xff2A1B3D),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: baseColor.withValues(alpha: .9),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: 100,
                      decoration: BoxDecoration(
                        color: baseColor.withValues(alpha: .8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 8,
                      width: 60,
                      decoration: BoxDecoration(
                        color: baseColor.withValues(alpha: .8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

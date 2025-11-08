
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../utils/colors.dart';

class MyShimmer extends StatelessWidget {
  const MyShimmer({
    super.key,
    required this.imageFlexValue,
    required this.containerFlexValue,
    required this.padding,
    required this.heightSize,
  });

  final int imageFlexValue;
  final int containerFlexValue;
  final double padding;
  final double heightSize;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1500),
      interval: const Duration(milliseconds: 0),
      color: kShimmerHighlightedColor,
      colorOpacity: 0.6,
      direction: const ShimmerDirection.fromLeftToRight(),
      enabled: true,
      child: Card(
        elevation: 0,
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
                child: Container(
                  color: kShimmerColor,
                ),
              ),
              Expanded(
                flex: containerFlexValue,
                child: Container(
                  color: kBgColor1,
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 14,
                          width: 80,
                          decoration: BoxDecoration(
                            color: kShimmerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: heightSize + 8),
                        Container(
                          height: 14,
                          width: 200,
                          decoration: BoxDecoration(
                            color: kShimmerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

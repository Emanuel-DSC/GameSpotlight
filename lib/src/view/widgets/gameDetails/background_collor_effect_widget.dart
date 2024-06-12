import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class BgCollorEffect extends StatelessWidget {
  const BgCollorEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, kBgColor2, kBgColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.25, 0.35, 3],
          ),
        ),
      ),
    );
  }
}

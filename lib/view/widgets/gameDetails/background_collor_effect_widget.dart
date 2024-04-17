import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

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
            colors: [Colors.transparent, Colors.black, kBgColor1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.25, 0.35, 3],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('lib/src/assets/animation/loading.json',
        height: 50, width: 50, fit: BoxFit.cover);
  }
}

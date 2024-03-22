import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Colors.cyan,
      backgroundColor: kBgColor1,
    );
  }
}
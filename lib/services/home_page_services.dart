import 'dart:ui';

import 'package:flutter/material.dart';

import '../view/widgets/my_progress_indicador_widget.dart';

class HomePageServices {
  Widget buildLoadingIndicator() {
  return Center(
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 50.0,
        sigmaY: 50.0,
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: const MyCircularProgressIndicator(),
      ),
    ),
  );
}

Widget buildErrorText(String error) {
  return Center(
    child: Text(
      error,
      style: const TextStyle(
        color: Colors.amber,
        fontSize: 28,
      ),
    ),
  );
}

Widget buildEmptyListText() {
  return const Center(
    child: Text(
      'Empty list',
      style: TextStyle(
        color: Colors.amber,
        fontSize: 28,
      ),
    ),
  );
}
}


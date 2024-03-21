import 'package:flutter/material.dart';

class GameDetailPage extends StatelessWidget {
  final String? title;

  const GameDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(title ?? 'Not found'),
      ),
    );
  }
}

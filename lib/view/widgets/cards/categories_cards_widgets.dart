import 'package:flutter/material.dart';

class CategoriesCards extends StatelessWidget {
  final VoidCallback onTap;
  const CategoriesCards({
    super.key,
    required this.item,
    required this.onTap,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

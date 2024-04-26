import 'dart:ui';

import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const AppBarButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20.0,
          sigmaY: 2.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            icon: Icon(icon),
            onPressed: () {
              onTap();
            },
          ),
        ),
      ),
    );
  }
}

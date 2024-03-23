import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MyButton extends StatelessWidget {
  final VoidCallback launchUrl;
  const MyButton({
    super.key,
    required this.launchUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kButtonColor1, kButtonColor2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: const [0.3, 0.7],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: kButtonColor1.withOpacity(0.5),
            spreadRadius: 0.05,
            blurRadius: 10,
            offset: const Offset(0, 3), // Offset (horizontal, vertical)
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          launchUrl();
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 12.0),
            )),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Play now'),
            Icon(Icons.arrow_forward_outlined),
          ],
        ),
      ),
    );
  }
}

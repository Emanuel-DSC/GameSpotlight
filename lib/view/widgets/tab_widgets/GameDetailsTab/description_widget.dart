import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionList extends StatelessWidget {
  const DescriptionList({super.key, required this.description});
  final Future<String> description;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: description,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: MyText(
              title: snapshot.data ?? 'Description not available',
              fontSize: 14.0,
              googleFont: GoogleFonts.roboto,
              color: Colors.grey.shade300,
              weight: FontWeight.normal,
            ),
          );
        }
      },
    );
  }
}

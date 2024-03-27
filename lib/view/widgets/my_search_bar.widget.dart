import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import 'my_text.widget.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: kSearchBarColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kCardColor),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.search_outlined,
              color: Colors.grey,
            ),
            SizedBox(width: 10),
            MyText(
              googleFont: GoogleFonts.roboto,
              color: Colors.grey,
              fontSize: 14,
              title: 'Search free game',
              weight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/game/game_detail_page.dart';
import '../my_text.widget.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.widget,
  });

  final GameDetailPage widget;


  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      runAlignment: WrapAlignment.spaceEvenly,
      spacing: 12,
      children: [
        MyText(
          title: // get only year from release
              (widget.releaseDate != null &&
                      widget.releaseDate!.isNotEmpty)
                  ? DateTime.parse(widget.releaseDate!)
                      .year
                      .toString()
                  : 'XXXX',
          fontSize: 12.0,
          googleFont: GoogleFonts.michroma,
          color: Colors.grey,
          weight: FontWeight.bold,
        ),
        MyText(
          title: widget.genre ?? 'Not found',
          fontSize: 12.0,
          googleFont: GoogleFonts.michroma,
          color: Colors.grey,
          weight: FontWeight.bold,
        ),
        MyText(
          title: widget.publisher ?? 'Not found',
          fontSize: 12.0,
          googleFont: GoogleFonts.michroma,
          color: Colors.grey,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
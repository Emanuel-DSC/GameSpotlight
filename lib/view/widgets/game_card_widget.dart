import 'package:cached_network_image/cached_network_image.dart';
import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/games_models.dart';
import 'my_progress_indicador_widget.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final GameModel item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: item.thumbnail ?? 'Not found',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.white.withOpacity(0.2),
                    alignment: Alignment.center,
                    child: const MyCircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            // Container with description
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                        googleFont: GoogleFonts.zenDots,
                        color: Colors.white,
                        fontSize: 14.0,
                        title: item.title ?? 'Title not available',
                        weight: FontWeight.normal),
                    const SizedBox(height: 8),
                    MyText(
                        googleFont: GoogleFonts.zenDots,
                        color: Colors.grey,
                        fontSize: 10.0,
                        title: item.genre ?? 'Genre not available',
                        weight: FontWeight.normal),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

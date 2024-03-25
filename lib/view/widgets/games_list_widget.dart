import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../pages/game/game_detail_page.dart';
import '../pages/stores/games_store.dart';
import 'game_card_widget.dart';

class GamesList extends StatelessWidget {
  const GamesList({
    super.key,
    required this.store,
  });

  final GameStore store;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CarouselSlider.builder(
        options: CarouselOptions(height: 300),
        itemCount: store.state.value.length,
        itemBuilder: (context, index, realIndex) {
          final item = store.state.value[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GameCard(
              item: item,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameDetailPage(
                    title: item.title,
                    thumbnail: item.thumbnail,
                    releaseDate: item.releaseDate,
                    id: item.id,
                    gameUrl: item.url,
                    genre: item.genre,
                    publisher: item.publisher,
                    description: '',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

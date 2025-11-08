import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/repositories/games_store_controller.dart';
import '../../../../models/game_model.dart';
import '../../../pages/game/game_detail_page.dart';
import '../../../pages/search_page.dart';
import '../../cards/game_card_widget.dart';

class GamesList extends StatelessWidget {
  const GamesList({
    super.key,
    required this.store,
    required this.state,
  });

  final GameStore store;
  final List<GameModel> state;

  @override
  Widget build(BuildContext context) {
    // Updates titles to search bar
    CustomSearchDelegate(store).updateSearchTerms(state);

    return SizedBox(
      height: 300,
      child: CarouselSlider.builder(
        options: CarouselOptions(
            padEnds: false, enableInfiniteScroll: false, height: 300),
        itemCount: state.length,
        itemBuilder: (context, index, realIndex) {
          final item = state[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GameCard(
              item: item,
              heightSize: 8.0,
              containerFlexValue: 3,
              imageFlexValue: 4,
              padding: 14.0,
              fit: BoxFit.cover,
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
                    shortDescription: '',
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

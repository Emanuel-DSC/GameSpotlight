import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../data/models/games_models.dart';
import '../../data/repositories/games_store.dart';
import '../../services/search_bar_services.dart';
import '../pages/game/game_detail_page.dart';
import 'cards/game_card_widget.dart';

class GamesList extends StatelessWidget {
  const GamesList({
    Key? key,
    required this.store,
    required this.state, 
  }) : super(key: key);

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
          padEnds: false,
          enableInfiniteScroll: false,
          height: 300),
        itemCount: state.length, 
        itemBuilder: (context, index, realIndex) {
          final item = state[index];
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
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
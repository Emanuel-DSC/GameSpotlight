import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/repositories/games_store_controller.dart';
import '../../../../models/game_model.dart';
import '../../../pages/game/game_detail_page.dart';
import '../../../pages/search_page.dart';
import '../../cards/game_card_widget.dart';

class CategoriesGamesList extends StatelessWidget {
  const CategoriesGamesList({
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
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Swiper(
          scrollDirection: Axis.vertical,
          itemHeight: 300,
          itemWidth: MediaQuery.of(context).size.width,
          layout: SwiperLayout.STACK,
          itemCount: state.length,
          itemBuilder: (BuildContext context, int index) {
            final item = state[index];
            return GameCard(
              fit: BoxFit.cover,
              item: item,
              containerFlexValue: 2,
              imageFlexValue: 4,
              padding: 8.0,
              heightSize: 0,
              onTap: () {
                // Navigate to game detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameDetailPage(
                      title: item.title ?? '',
                      thumbnail: item.thumbnail ?? '',
                      releaseDate: item.releaseDate,
                      id: item.id,
                      gameUrl: item.url,
                      genre: item.genre,
                      publisher: item.publisher,
                      description: '',
                    ),
                  ),
                );
              }, 
            );
          },
        ),
      ),
    );
  }
}

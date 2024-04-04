import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../../../../data/models/games_models.dart';
import '../../../../data/repositories/games_store.dart';
import '../../../../services/search_bar_services.dart';
import '../../../pages/game/game_detail_page.dart';
import '../../my_progress_indicador_widget.dart';

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

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: VerticalCardPager(
          titles: state.map((item) => item.title ?? '').toList(),
          images: state
              .map((item) => item.thumbnail != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: item.thumbnail!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.white.withOpacity(0.2),
                          alignment: Alignment.center,
                          child: const MyCircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ))
                  : const Placeholder())
              .toList(),
          textStyle: const TextStyle(color: Colors.transparent),
          onSelectedItem: (index) {
            final item = state[index];
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
          initialPage: 0,
          align: ALIGN.CENTER,
          physics: const ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

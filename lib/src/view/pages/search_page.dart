import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:f2p_games/utils/theme.dart';
import 'package:flutter/material.dart';
import '../../controllers/repositories/games_store_controller.dart';
import '../widgets/cards/search_cards_widget.dart';
import 'game/game_detail_page.dart';

class CustomSearchDelegate extends SearchDelegate {
  final GameStore store;
  static List<String> searchTerms = [];
  bool showCards = false;

  CustomSearchDelegate(this.store);

  // create a list view of game cards to search bar suggestions and results
  Widget _buildGameCardList(List<String> matchQuery) {
    return Visibility(
      visible: showCards,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          final String result = matchQuery[index];
          final item = store.state5.value.firstWhere((item) =>
              item.title.toString().toLowerCase() == result.toLowerCase());
          return GameCardList(
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
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> matchQuery = searchTerms
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildGameCardList(matchQuery),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> matchQuery = searchTerms
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Set showCards to true when the user starts typing
    if (query.isNotEmpty) {
      showCards = true;
    } else {
      showCards = false; // Hide cards when the search query is empty
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildGameCardList(matchQuery),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white,),
        onPressed: () {
          query = '';
          // Hide cards when the search query is cleared
          showCards = false;
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(EvaIcons.arrowIosBackOutline, color: Colors.white,),
    );
  }

  // get every title from api and add to search bar
  void updateSearchTerms(List items) {
    searchTerms.clear();
    for (var item in items) {
      searchTerms.add(item.title.toString());
    }
  }

  //style
  @override
  ThemeData appBarTheme(BuildContext context) {
    return appBarThemeData();
  }
}

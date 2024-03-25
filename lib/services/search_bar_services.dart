import 'package:flutter/material.dart';

import '../view/pages/game/game_detail_page.dart';
import '../view/pages/stores/games_store.dart';

class CustomSearchDelegate extends SearchDelegate {
  final GameStore store;

  static List<String> searchTerms = [];

  CustomSearchDelegate(this.store);

  // get every title from api and add to search bar
  void updateSearchTerms(List items) {
    searchTerms.clear();
    for (var item in items) {
      searchTerms.add(item.title.toString());
    }
  }
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
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
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var games in searchTerms) {
      if (games.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(games);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

@override
Widget buildSuggestions(BuildContext context) {
  List<String> matchQuery = [];
  for (var games in searchTerms) {
    if (games.toLowerCase().contains(query.toLowerCase())) {
      matchQuery.add(games);
    }
  }
  return ListView.builder(
    itemCount: matchQuery.length,
    itemBuilder: (context, index) {
      var result = matchQuery[index];
      final item = store.state.value[index];
      return ListTile(
        title: Text(result),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameDetailPage(
                title: result, 
                description: item.description, 
                gameUrl: item.url, 
                genre: item.genre, 
                id: item.id, 
                publisher: item.publisher, 
                releaseDate: item.releaseDate, 
                thumbnail:item.thumbnail),
            ),
          );
        },
      );
    },
  );
}

}

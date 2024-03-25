import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  static List<String> searchTerms = [];

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
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

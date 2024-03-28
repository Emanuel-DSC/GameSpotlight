import 'dart:ui';

import 'package:flutter/material.dart';

import '../view/widgets/my_progress_indicador_widget.dart';

class GameListPageServices {
  Widget buildLoadingIndicator() {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 50.0,
          sigmaY: 50.0,
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          child: const MyCircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildErrorText(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(
          color: Colors.amber,
          fontSize: 28,
        ),
      ),
    );
  }

  Widget buildEmptyListText() {
    return const Center(
      child: Text(
        'Empty list',
        style: TextStyle(
          color: Colors.amber,
          fontSize: 28,
        ),
      ),
    );
  }

  // Function to convert chip index to genre
  String getGenreFromIndex(int index) {
    // List of all genres
    List<String> genres = [
      '2d',
      '3d',
      'action',
      'action-rpg',
      'anime',
      'battle-royale',
      'card',
      'fantasy',
      'fighting',
      'first-person',
      'flight',
      'horror',
      'low-spec',
      'martial-arts',
      'military',
      'mmo',
      'mmofps',
      'mmorpg',
      'mmorts'
      'mmotps',
      'moba',
      'open-world',
      'permadeath',
      'pixel',
      'pve',
      'pvp',
      'racing',
      'sailing',
      'sandbox',
      'sci-fi',
      'shooter',
      'side-scroller',
      'social',
      'space',
      'sports',
      'strategy',
      'superhero',
      'survival',
      'tank',
      'third-Person',
      'top-down',
      'tower-defense',
      'turn-based',
      'voxel',
      'zombie',
    ];
    // Return the genre corresponding to the index
    return genres[index];
  }
}

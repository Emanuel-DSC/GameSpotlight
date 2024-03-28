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
      'mmorpg',
      'shooter',
      'strategy',
      'moba',
      'racing',
      'sports',
      'social',
      'sandbox',
      'open-world',
      'survival',
      'pvp',
      'pve',
      'pixel',
      'voxel',
      'zombie',
      'turn-based',
      'first-person',
      'third-Person',
      'top-down',
      'tank',
      'space',
      'sailing',
      'side-scroller',
      'superhero',
      'permadeath',
      'card',
      'battle-royale',
      'mmo',
      'mmofps',
      'mmotps',
      '3d',
      '2d',
      'anime',
      'fantasy',
      'sci-fi',
      'fighting',
      'action-rpg',
      'action',
      'military',
      'martial-arts',
      'flight',
      'low-spec',
      'tower-defense',
      'horror',
      'mmorts'
    ];
    // Return the genre corresponding to the index
    return genres[index];
  }
}




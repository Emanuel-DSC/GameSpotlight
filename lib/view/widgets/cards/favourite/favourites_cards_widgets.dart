import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2p_games/view/pages/game/game_detail_page.dart';
import 'package:f2p_games/view/widgets/cards/favourite/favourites_design_widget.dart';
import 'package:flutter/material.dart';

Widget favouritesCard(QueryDocumentSnapshot doc, context) {
  // Access the entire document data as a Map
  Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

  // Check if data is null or the required fields are missing
  if (data == null || !data.containsKey('game_name')) {
    return const SizedBox(); // Return an empty widget if the required fields are missing
  }

  // Access document fields
  String gameName = data['game_name'];
  String gameCover = data['game_cover'];
  String gameLaunch = data['game_launch'];
  String gameDescription = data['game_description'];
  String gameId = data['game_id'];
  String gameCategory = data['game_category'];
  String gamePublisher = data['game_publisher'];

  // variables
  double height = 160;

  // Build the card widget using the accessed fields
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      // go to favourite clicked game
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailPage(
              title: gameName,
              thumbnail: gameCover,
              releaseDate: gameLaunch,
              description: gameDescription,
              id: gameId,
              gameUrl: '',
              genre: gameCategory,
              publisher: gamePublisher,
            ),
          ),
        );
      },
      // favourite card design
      child: FavouriteCardDesign(height: height, gameCover: gameCover, gameName: gameName, gameLaunch: gameLaunch, gameCategory: gameCategory),
    ),
  );
}



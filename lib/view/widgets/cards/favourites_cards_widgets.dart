import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2p_games/view/pages/game/game_detail_page.dart';
import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      child: Row(
        children: [
          Container(
            height: 182,
            width: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              child: Image.network(
                gameCover,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: MyCircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              height: 182,
              width: 215,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gameName,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          gameLaunch,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Remove game from Firebase and consequently from favourites list
                            FirebaseFirestore.instance
                                .collection("Users")
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('favourites')
                                .doc(gameName)
                                .delete();
                          },
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


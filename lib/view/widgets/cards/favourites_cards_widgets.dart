import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/view/pages/game/game_detail_page.dart';
import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:f2p_games/view/widgets/text/my_text.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  double height = 180;

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
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: [
            Flexible(
              flex: 9,
              child: Container(
                height: height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
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
            ),
            Flexible(
              flex: 10,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 150.0,
                    sigmaY: 150.0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: height,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      color: Colors.transparent,
                    ),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyText(
                              googleFont: GoogleFonts.lato,
                              color: Colors.white,
                              fontSize: 18,
                              title: gameName,
                              weight: FontWeight.normal),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                  googleFont: GoogleFonts.lato,
                                  color: Colors.grey,
                                  fontSize: 16,
                                  title: DateTime.parse(gameLaunch)
                                      .year
                                      .toString(),
                                  weight: FontWeight.bold),
                              MyText(
                                  googleFont: GoogleFonts.lato,
                                  color: Colors.grey,
                                  fontSize: 16,
                                  title: gameCategory,
                                  weight: FontWeight.bold),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: kSearchBarColor,
                                      title: const Text(
                                        "Delete Game",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      content: const Text(
                                        "Are you sure you want to delete this game from favorites?",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Remove game from Firebase and consequently from favorites list
                                            FirebaseFirestore.instance
                                                .collection("Users")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser?.uid)
                                                .collection('favourites')
                                                .doc(gameName)
                                                .delete();
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Delete",
                                            style:
                                                TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2p_games/view/pages/game/game_detail_page.dart';
import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget favouritesCard(QueryDocumentSnapshot doc, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
        // go to favourite clicked movie
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GameDetailPage(
                      title: doc['game_name'],
                      thumbnail: doc['game_cover'],
                      releaseDate: doc['game_launch'],
                      description: doc['game_description'],
                      id: doc['game_id'],
                      gameUrl: '',
                      genre: doc['game_category'],
                      publisher: doc['game_publisher'])));
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
                    bottomLeft: Radius.circular(5)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
                child: Image.network(doc['game_cover'], fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(child: MyCircularProgressIndicator());
                  }
                }),
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
                      bottomRight: Radius.circular(5)),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doc['game_name'],
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(doc['game_launch'],
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)),
                          GestureDetector(
                              onTap: () {
                                //remove movie from Firebase and consequently from favourites list
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection('favourites')
                                    .doc(doc['game_name'])
                                    .delete();
                              },
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
  );
}

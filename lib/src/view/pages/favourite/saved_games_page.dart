import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/colors.dart';
import '../../widgets/cards/favourite/favourites_cards_widgets.dart';
import '../../widgets/my_progress_indicador_widget.dart';
import '../../widgets/text/my_text.widget.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  FavouritesPageState createState() => FavouritesPageState();
}

class FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Favourites',),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22), 
        centerTitle: true,
      ),
      backgroundColor: kBgColor1,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('favourites')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //checking connection state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: MyCircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LottieBuilder.network(
                            'https://lottie.host/85b0686f-fad8-4930-a12f-704af412d345/AG04t7ZsMf.json'),
                        const SizedBox(height: 10),
                        const MyText(
                          googleFont: GoogleFonts.lato,
                          color: Colors.white,
                          fontSize: 32,
                          title: 'Ohh nooo!',
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(height: 10),
                        const MyText(
                          googleFont: GoogleFonts.lato,
                          color: Colors.grey,
                          fontSize: 20,
                          title: "You don't have any game saved yet",
                          weight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: snapshot.data!.docs
                      .map((favourite) => favouritesCard(favourite, context))
                      .toList(),
                );
              }
            }
            return const Center(
              child: Text("Error loading favorites"),
            );
          },
        ),
      ),
    );
  }
}

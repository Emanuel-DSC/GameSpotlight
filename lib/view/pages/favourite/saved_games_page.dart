import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/cards/favourites_cards_widgets.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
 
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder<QuerySnapshot>(
              stream:    
              FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('favourites')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //checking connection state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!.docs
                        .map(
                            (favourite) => favouritesCard(favourite, context))
                        .toList(),
                  );
                }
                return Center(
                  child: Text("There's no favourites",
                      style: GoogleFonts.lato(color: Colors.white)),
                );
              }),
        ),
      ),
    );
  }
}
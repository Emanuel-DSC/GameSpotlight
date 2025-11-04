import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SaveGameModel {
  final String? id;
  final String? name;
  final String? description;
  final String? shortDescription;
  final String? cover;
  final String? publisher;
  final String? launch;
  final String? category;
  final String? sysReq;
  const SaveGameModel({
    Key? key,
    required this.name,
    required this.id,
    required this.description,
    this.shortDescription,
    required this.launch,
    required this.cover,
    required this.publisher,
    required this.category,
    required this.sysReq,
  }) : super();

  // like button function
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    // remove movie from firestore
    if (isLiked == true) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('favourites')
          .doc(name)
          .delete();

      // add movie to firestore
    } else {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('favourites')
          .doc(name)
          .set({
        "game_name": name,
        "game_cover": cover,
        "game_description": description,
        "short_description": shortDescription,
        "game_launch": launch,
        "game_publisher": publisher,
        "game_category": category,
        "game_sys_requirement": sysReq,
        "game_id": id,
      });
    }

    return !isLiked;
  }
}

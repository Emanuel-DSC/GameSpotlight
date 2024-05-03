import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../my_progress_indicador_widget.dart';
import '../text/my_text.widget.dart';

class ReturnEmail extends StatelessWidget {
  const ReturnEmail({
    super.key,
    required this.user,
  });

  final String user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(user)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyCircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(child: Text('no data'));
            } else {
              Map<String, dynamic>? data;
              data = snapshot.data.data();
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                child: Center(
                  child: Column(children: [
                    const SizedBox(height: 10),
                    MyText(
                        googleFont: GoogleFonts.lato,
                        color: Colors.white,
                        fontSize: 18,
                        title:  'email: ${data?['Email'] ?? 'Change your name :)'}',
                        weight: FontWeight.normal),
                    const SizedBox(height: 10),
                  ]),
                ),
              );
            }
          } else if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
            // error
          } else {
            return const Text('Error'); // loading
          }
        });
  }
}
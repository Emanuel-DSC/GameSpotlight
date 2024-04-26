import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/data/auth/auth_service.dart';
import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/text/my_text.widget.dart';
import '../auth/forget_password_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser?.uid ?? 'No user found';

    return Scaffold(
      backgroundColor: kBgColor1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyText(
                  googleFont: GoogleFonts.lato,
                  color: Colors.grey,
                  fontSize: 40,
                  title: 'Logged as',
                  weight: FontWeight.bold),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
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
                                  title:
                                      data?['Email'] ?? 'Change your name :)',
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
                  }),
              const SizedBox(
                height: 50,
              ),
              ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.deepPurple,
                    BlendMode.modulate,
                  ),
                  child: LottieBuilder.network(
                      'https://lottie.host/b6338086-12fa-43b5-905f-45a38cf29aca/Qvl8VkGT1n.json')),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgetPasswordPage()));
                },
                child: const MyText(
                    googleFont: GoogleFonts.lato,
                    color: Colors.grey,
                    fontSize: 18,
                    title: 'Change password',
                    weight: FontWeight.normal),
              ),
              GestureDetector(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                        googleFont: GoogleFonts.lato,
                        color: Colors.red,
                        fontSize: 18,
                        title: 'Logout',
                        weight: FontWeight.normal),
                    SizedBox(width: 5),
                    Icon(
                      EvaIcons.logOutOutline,
                      color: Colors.red,
                    ),
                  ],
                ),
                onTap: () {
                  AuthenticationRepository().logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

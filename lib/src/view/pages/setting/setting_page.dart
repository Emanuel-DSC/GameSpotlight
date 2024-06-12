import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/colors.dart';
import '../../widgets/settings/info_container_widget.dart';
import '../../widgets/text/my_text.widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse('https://www.freetogame.com'))) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser?.uid ?? 'No user found';

    return Scaffold(
      backgroundColor: kBgColor1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              const MyText(
                  googleFont: GoogleFonts.lato,
                  color: Colors.grey,
                  fontSize: 40,
                  title: 'Account Info',
                  weight: FontWeight.bold),
              const SizedBox(
                height: 60,
              ),
              InfoContainer(user: user),
              SizedBox(height: MediaQuery.of(context).size.height * 0.16),
              const MyText(
                  googleFont: GoogleFonts.lato,
                  color: Colors.grey,
                  fontSize: 18,
                  title: 'This app is powered by',
                  weight: FontWeight.bold),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _launchUrl();
                },
                child: MyText(
                    googleFont: GoogleFonts.lato,
                    color: kButtonColor2,
                    fontSize: 16,
                    title: 'Freetogame.com',
                    weight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

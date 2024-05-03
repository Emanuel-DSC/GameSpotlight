import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/data/auth/auth_service.dart';
import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/buttons/settings_button.dart';
import '../../widgets/settings/user_email_widget.dart';
import '../../widgets/text/my_text.widget.dart';
import '../auth/forget_password_page.dart';

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const MyText(
                  googleFont: GoogleFonts.lato,
                  color: Colors.grey,
                  fontSize: 40,
                  title: 'Account Info',
                  weight: FontWeight.bold),
              const SizedBox(
                height: 30,
              ),
              ReturnEmail(user: user),
              const SizedBox(
                height: 20,
              ),
              SettingsButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgetPasswordPage()));
                },
                color: Colors.grey,
                text: 'Change password',
                icon: EvaIcons.editOutline,
              ),
              const SizedBox(
                height: 20,
              ),
              SettingsButton(
                onTap: () {
                  AuthenticationRepository().logout(context);
                },
                color: Colors.red,
                text: 'Logout',
                icon: EvaIcons.logOutOutline,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              const MyText(
                  googleFont: GoogleFonts.lato,
                  color: Colors.grey,
                  fontSize: 18,
                  title: 'This app is powered by',
                  weight: FontWeight.bold),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                height: MediaQuery.of(context).size.height * 0.05,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://www.freetogame.com/assets/images/freetogame-logo.png',
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(
                    color: Colors.black,
                    child: const Center(child: MyCircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  _launchUrl();
                },
                child: MyText(
                    googleFont: GoogleFonts.lato,
                    color: kButtonColor2,
                    fontSize: 16,
                    title: 'Click here to acess it',
                    weight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

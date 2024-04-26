import 'package:f2p_games/view/pages/auth/sign_up_page.dart';
import 'package:f2p_games/view/widgets/buttons/login_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';
import '../../widgets/text/my_text.widget.dart';
import 'login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kCardColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: kCardColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Center(
                    child: Image.asset(
                  'lib/src/assets/images/logo.png',
                  fit: BoxFit.cover,
                )),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Expanded(
              flex: 3,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const MyText(
                            googleFont: GoogleFonts.lato,
                            color: Colors.grey,
                            fontSize: 18,
                            title:
                                'Discover endless adventures! Dive into diverse titles, from action to puzzles. Let the gaming journey begin!',
                            weight: FontWeight.normal,
                            align: TextAlign.center,
                          ),
                          const SizedBox(height: 50),
                          LoginButton(
                            title: 'Login',
                            iconDisplay: false,
                            textColor: Colors.white,
                            bgColor: kButtonColor2,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                            },
                          ),
                          const SizedBox(height: 10),
                          LoginButton(
                            title: 'Create a new account',
                            iconDisplay: false,
                            textColor: Colors.white,
                            bgColor: kBgColor1,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                            },
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

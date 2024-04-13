import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';
import '../../widgets/my_text.widget.dart';
import '../../widgets/signup/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kCardColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration:  BoxDecoration(
                  color: kCardColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                ),
                child: Center(child: Image.asset('lib/src/assets/images/logo.png', 
                fit: BoxFit.cover,)),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                  decoration: BoxDecoration(
                    color: kBgColor1,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(
                              googleFont: GoogleFonts.lato,
                              color: Colors.grey,
                              fontSize: 24,
                              title: 'Sign Up',
                              weight: FontWeight.normal),
                          SizedBox(height: 20),
                          SignUpForm(),
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
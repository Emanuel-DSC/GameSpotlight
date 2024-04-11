import 'package:flutter/material.dart';

import '../widgets/login/login_form_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // o resize tira o scroll
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // theme on image
                // FormHeaderWidget(
                //     isDarkMode: isDarkMode,
                //     size: size,
                //     title: tLoginText,
                //     subtitle: tLoginText2,
                //     image: tWelcomeImage_dark,
                //     imageDark: tWelcomeImage),
                SizedBox(height: 20),
                LoginForm(),
                // FormFooter(
                //   buttonTitle1: tLoginText6,
                //   buttonTitle2: tLoginText7,
                //   buttonTitle3: tLoginText9,
                //   onTap: () {
                //     Get.to(() => const SignUpScreen());
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
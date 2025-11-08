import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/colors.dart';
import '../../../controllers/auth_repo_controller.dart';
import '../../widgets/auth/email_textfield_widget.dart';
import '../../widgets/buttons/login_button_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  static final emailController = TextEditingController();
  bool playAnimation = false;

  @override
  void dispose() {
    super.dispose();
  }

  void callback(bool animation) {
    setState(() {
      playAnimation = animation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor1,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Visibility(
            visible: playAnimation ? false : true,
            child: IconButton(
                icon: const Icon(EvaIcons.arrowIosBack, color: Colors.white),
                onPressed: () => Navigator.of(context).pop()),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Center(
                  child: playAnimation
                      ? Lottie.network(
                          'https://lottie.host/72396abc-43d4-4bf3-863e-7e6ef4b41de9/Yu9H16JbZM.json',
                          repeat: false,
                        )
                      : LottieBuilder.network(
                          'https://lottie.host/72396abc-43d4-4bf3-863e-7e6ef4b41de9/Yu9H16JbZM.json',
                          animate: false,
                          repeat: false,
                        ),
                ),
                const SizedBox(height: 30),
                EmailTextField(
                    textFieldFocusPassword: FocusNode(),
                    emailController: emailController),
                const SizedBox(height: 10),
                LoginButton(
                    onTap: () {
                      // Send password reset email and then play Lottie animation
                      AuthenticationRepositoryController().passwordReset(context, callback);
                      // clear email controller
                      emailController.clear();
                    },
                    title: 'Send',
                    iconDisplay: false,
                    textColor: Colors.white,
                    bgColor: kCardColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

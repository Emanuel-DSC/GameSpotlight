import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/view/pages/forgetPassword/forget_password_page.dart';
import 'package:f2p_games/view/pages/signUp/sign_up_page.dart';
import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/auth/auth_service.dart';
import '../buttons/login_button_widget.dart';
import '../email_textfield_widget.dart';
import '../password_textfiled_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
// text editing controllers
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  bool _obscureTextController = true;
  FocusNode textFieldFocusPassword = FocusNode();

  void _toggleObscureText() {
    setState(() {
      _obscureTextController = !_obscureTextController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          EmailTextField(
              textFieldFocusPassword: textFieldFocusPassword,
              emailController: emailController),
          const SizedBox(height: 10),
          PasswordTextFormField(
            textFieldFocusPassword: textFieldFocusPassword,
            obscurePasswordTextController: _obscureTextController,
            passwordController: passwordController,
            color: kButtonColor2,
            labelText: 'Password',
            onTap: () {
              _toggleObscureText();
            },
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ForgetPasswordPage()));
              },
              child: MyText(
                  googleFont: GoogleFonts.lato,
                  color: kButtonColor2,
                  fontSize: 14,
                  title: 'Forgot password?',
                  weight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 10),
          LoginButton(
            onTap: () {
              AuthenticationRepository().signUserIn(context);
            },
            iconDisplay: false,
            title: 'login',
            bgColor: kButtonColor2,
            textColor: Colors.white,
          ),
          const SizedBox(height: 10),
          LoginButton(
            onTap: () {
              AuthenticationRepository().signInWithGoogle(context);
            },
            iconDisplay: true,
            title: 'login with google',
            bgColor: Colors.white,
            textColor: Colors.grey.shade800,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyText(
                  googleFont: GoogleFonts.lato,
                  color: Colors.grey,
                  fontSize: 14,
                  title: "Don't have account?",
                  weight: FontWeight.normal),
              TextButton(
                onPressed: () {
                  // go to sign up page
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpPage()));
                },
                child: MyText(
                    googleFont: GoogleFonts.lato,
                    color: kButtonColor2,
                    fontSize: 14,
                    title: 'Create one!',
                    weight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}

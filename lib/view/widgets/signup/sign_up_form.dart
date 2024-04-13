// ignore_for_file: file_names
import 'package:f2p_games/view/widgets/email_textfield_widget.dart';
import 'package:f2p_games/view/widgets/password_textfiled_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../data/auth/auth_service.dart';
import '../buttons/login_button_widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
// text editing controllers
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  static var passwordConfirmController = TextEditingController();
  FocusNode textFieldFocusPassword = FocusNode();
  FocusNode textFieldFocusConfirmPassword = FocusNode();
  bool _obscurePasswordTextController = true;
  bool _obscureConfirmPasswordTextController = true;

  void _toggleObscureText() {
    setState(() {
      _obscurePasswordTextController = !_obscurePasswordTextController;
    });
  }

  void _toggleObscureText2() {
    setState(() {
      _obscureConfirmPasswordTextController =
          !_obscureConfirmPasswordTextController;
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
            obscurePasswordTextController: _obscurePasswordTextController,
            passwordController: passwordController,
            color: kButtonColor2,
            labelText: 'Password',
            onTap: () {
              _toggleObscureText();
            },
          ),
          const SizedBox(height: 10),
          PasswordTextFormField(
            textFieldFocusPassword: textFieldFocusConfirmPassword,
            obscurePasswordTextController:
                _obscureConfirmPasswordTextController,
            passwordController: passwordConfirmController,
            color: kButtonColor2,
            labelText: 'Confirm password',
            onTap: () {
              _toggleObscureText2();
            },
          ),
          const SizedBox(height: 30),
          LoginButton(
            onTap: () {
              AuthenticationRepository().signUserUp(context);
            },
            iconDisplay: false,
            title: 'Sign up',
            bgColor: kButtonColor2,
            textColor: Colors.white,
          ),
          const SizedBox(height: 10),
          LoginButton(
            onTap: () {
              AuthenticationRepository().signInWithGoogle(context);
            },
            iconDisplay: true,
            title: 'sign up with google',
            bgColor: Colors.white,
            textColor: Colors.grey.shade800,
          ),
        ],
      ),
    );
  }
}

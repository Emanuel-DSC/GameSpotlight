// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/colors.dart';
import '../../../../controllers/auth_repo_controller.dart';
import '../../../pages/auth/login_page.dart';
import '../../buttons/login_button_widget.dart';
import '../../text/my_text.widget.dart';
import '../email_textfield_widget.dart';
import '../password_textfiled_widget.dart';

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
              AuthenticationRepositoryController().signUserUp(context);
            },
            iconDisplay: false,
            title: 'Sign up',
            bgColor: kButtonColor2,
            textColor: Colors.white,
          ),
          const SizedBox(height: 10),
          LoginButton(
            onTap: () {
              AuthenticationRepositoryController().signInWithGoogle(context);
            },
            iconDisplay: true,
            title: 'sign up with google',
            bgColor: Colors.white,
            textColor: Colors.grey.shade800,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyText(
                  googleFont: GoogleFonts.lato,
                  color: Colors.grey,
                  fontSize: 14,
                  title: "Already have account?",
                  weight: FontWeight.normal),
              TextButton(
                onPressed: () {
                  // go to sign up page
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                child: MyText(
                    googleFont: GoogleFonts.lato,
                    color: kButtonColor2,
                    fontSize: 14,
                    title: 'Sign in',
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

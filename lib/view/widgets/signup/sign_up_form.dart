// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../../data/auth/auth_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

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
      _obscureConfirmPasswordTextController = !_obscureConfirmPasswordTextController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          TextFormField(
            // onFieldSumbitted go to password text field
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(textFieldFocusPassword),
            controller: emailController,
            decoration: const InputDecoration(
              label: Text('email'),
              prefixIcon: Icon(Icons.mail_outline_rounded),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: textFieldFocusPassword,
            // onFieldSumbitted go to confirm password text field
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(textFieldFocusConfirmPassword),
            controller: passwordController,
            obscureText: _obscurePasswordTextController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.fingerprint),
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: _toggleObscureText,
                icon: _obscurePasswordTextController ? const Icon(EvaIcons.eye)  
                : const Icon(EvaIcons.eyeOff),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: textFieldFocusConfirmPassword,
            controller: passwordConfirmController,
            obscureText: _obscureConfirmPasswordTextController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.fingerprint),
              labelText: 'Confirm password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: _toggleObscureText2,
                icon: _obscureConfirmPasswordTextController ? const Icon(EvaIcons.eye)  
                : const Icon(EvaIcons.eyeOff),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('SIGN UP') ,
            onPressed: () {
              AuthenticationRepository().signUserUp(context);
            },
          ),
        ],
      ),
    );
  }
}
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../data/auth/auth_service.dart';

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
          TextFormField(
            // onFieldSumbitted go to password text field
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(textFieldFocusPassword),
            controller: emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: textFieldFocusPassword,
            obscureText: _obscureTextController,
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.fingerprint),
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: _toggleObscureText,
                icon: _obscureTextController
                    ? const Icon(EvaIcons.eye)
                    : const Icon(EvaIcons.eyeOff),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                //cria um container pop up inferior
                // ForgetPasswordScreen.buildShowModalBottomSheet(context);
              },
              child: const Text('Forget password ?'),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: () {
              AuthenticationRepository().signUserIn(context);
            },
          ),
        ],
      ),
    );
  }
}

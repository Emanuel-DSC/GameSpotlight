import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.textFieldFocusPassword,
    required this.emailController,
  });

  final FocusNode textFieldFocusPassword;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      cursorColor: kButtonColor2,
      // onFieldSumbitted go to password text field
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(textFieldFocusPassword),
      controller: emailController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_outline_outlined),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? kButtonColor2
                : Colors.grey),
        labelText: 'Email',
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: TextStyle(
            color: textFieldFocusPassword.hasFocus
                ? kButtonColor2
                : Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: kButtonColor2),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
  }
}
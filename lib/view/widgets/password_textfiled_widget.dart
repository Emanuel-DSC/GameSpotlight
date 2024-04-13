import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.textFieldFocusPassword,
    required bool obscurePasswordTextController,
    required this.passwordController,
    required this.color,
    required this.onTap, required this.labelText,
  }) : _obscurePasswordTextController = obscurePasswordTextController;

  final FocusNode textFieldFocusPassword;
  final bool _obscurePasswordTextController;
  final TextEditingController passwordController;
  final Color color;
  final VoidCallback onTap;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      cursorColor: color,
      focusNode: textFieldFocusPassword,
      obscureText: _obscurePasswordTextController,
      controller: passwordController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.fingerprint),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused) ? color : Colors.grey),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: TextStyle(color: color),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: color),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        suffixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused) ? color : Colors.grey),
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: _obscurePasswordTextController
              ? const Icon(EvaIcons.eye)
              : const Icon(EvaIcons.eyeOff),
        ),
      ),
    );
  }
}

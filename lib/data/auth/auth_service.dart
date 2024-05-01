// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2p_games/view/pages/auth/intro_page.dart';
import 'package:f2p_games/view/pages/home/home_page.dart';
import 'package:f2p_games/view/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../view/pages/auth/forget_password_page.dart';
import '../../view/pages/auth/login_page.dart';
import '../../view/widgets/auth/login/login_form_widget.dart';
import '../../view/widgets/auth/signup/show_error_message_widget.dart';
import '../../view/widgets/auth/signup/sign_up_form.dart';
import '../../view/widgets/my_alert_dialog_widget.dart';
import '../../view/widgets/my_progress_indicador_widget.dart';

class AuthenticationRepository with ChangeNotifier {
  //variables
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _firebaseUser;
  late final String _verificationId = '';

  AuthenticationRepository() {
    // Load user when the app launches
    _loadUser();
  }

  User? get firebaseUser => _firebaseUser;

  String get verificationId => _verificationId;

  // Load user when app launches
  Future<void> _loadUser() async {
    _firebaseUser = _auth.currentUser;
    notifyListeners();
    _auth.userChanges().listen((user) {
      _firebaseUser = user;
      notifyListeners();
    });
  }

  // setting initial screen on load
  Widget getInitialScreen() {
    return _firebaseUser == null ? const HomePage() : const ProfilePage();
  }

  // logout user
  Future<void> logout(context) async {
    await _auth.signOut();
    _firebaseUser = null;
    notifyListeners();
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const IntroPage()),
    );
  }

  // sign user up method
  void signUserUp(context) async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: MyCircularProgressIndicator(),
        );
      },
    );

    // check if passwords are the same
    if (SignUpFormState.passwordController.text !=
        SignUpFormState.passwordConfirmController.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords do not match", context);
      return;
    }

    // try sign Up
    try {
      // Create user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: SignUpFormState.emailController.text,
        password: SignUpFormState.passwordController.text.trim(),
      );

      // Send email verification
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();

      // create user in Users collection Firebase
      var user = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance.collection('Users').doc(user).set({
        'Email': SignUpFormState.emailController.text.trim(),
      });

      // pop the loading circle
      Navigator.pop(context);

      // Show message to verify email
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Verify Email'),
            content: const Text(
                'A verification email has been sent to your email address. Please verify your email before continuing.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const LoginPage()));
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      // Check if email is filled
      if (e.code == 'channel-error') {
        showErrorMessage("Please enter an email", context);
      } else {
        // Show error message
        showErrorMessage(e.code, context);
      }
    }
  }

  // sign user in method
  signUserIn(context) async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: MyCircularProgressIndicator(),
        );
      },
    );
    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: LoginFormState.emailController.text,
        password: LoginFormState.passwordController.text,
      );
      // pop the loading circle
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code, context);
    }
  }

  // reset user's password
  Future passwordReset(BuildContext context, Function callback) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: ForgetPasswordPageState.emailController.text.trim());
      // Set Lottie playAnimation to true before sending the password reset email
      callback(ForgetPasswordPageState().playAnimation = true);
      // Delay for the duration of the animation
      await Future.delayed(
          const Duration(seconds: 8)); // Adjust duration as needed
      // After animation is played, pop the page
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginPage()));
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return MyAlertDialog(
                message: 'error',
                message2: e.message.toString(),
                onTap: () {
                  // Set Lottie playAnimation to false if password reset fails
                  callback(ForgetPasswordPageState().playAnimation = false);
                  Navigator.of(context).pop();
                });
          });
    }
  }

  // ****************** GOOGLE ******************* //

  // Google sign in
  signInWithGoogle(context) async {
    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // create user in Users collection Firebase
    var user = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user)
        .set({'Email': gUser.email.toString()});

    //sign in
    return await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomePage())));
  }

  // google sign out
  signOutWithGoogle() async {
    if (await GoogleSignIn().isSignedIn()) {
      GoogleSignIn().signOut();
    }
  }
}

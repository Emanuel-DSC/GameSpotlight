// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2p_games/view/pages/forgetPassword/forget_password_page.dart';
import 'package:f2p_games/view/pages/home/home_page.dart';
import 'package:f2p_games/view/pages/login_page.dart';
import 'package:f2p_games/view/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../view/widgets/login/login_form_widget.dart';
import '../../view/widgets/my_alert_dialog_widget.dart';
import '../../view/widgets/my_progress_indicador_widget.dart';
import '../../view/widgets/signup/show_error_message_widget.dart';
import '../../view/widgets/signup/sign_up_form.dart';

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
  Future<void> logout() async {
    await _auth.signOut();
    _firebaseUser = null;
    notifyListeners();
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: SignUpFormState.emailController.text,
          password: SignUpFormState.passwordController.text.trim());

      // create user in Users collection Firebase
      var user = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user)
          .set({'Email': SignUpFormState.emailController.text.trim()});
      // get to movies screen
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      //check if email is filled
      if (e.toString() == 'channel-error') {
        showErrorMessage("Please enter an email", context);
      }

      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code, context);
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
  // reset user's password
Future passwordReset(BuildContext context, setState) async {
  try {
    // Set Lottie playAnimation to true before sending the password reset email
    setState(() {
      ForgetPasswordPageState().playAnimation = true;
    });
    await FirebaseAuth.instance.sendPasswordResetEmail(
        email: ForgetPasswordPageState.emailController.text.trim());
    // Delay for the duration of the animation
    await Future.delayed(const Duration(seconds: 8)); // Adjust duration as needed
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
                setState(() {
                  ForgetPasswordPageState().playAnimation = false;
                });
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

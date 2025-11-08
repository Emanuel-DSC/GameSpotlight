// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/pages/auth/forget_password_page.dart';
import '../view/pages/auth/intro_page.dart';
import '../view/pages/auth/login_page.dart';
import '../view/pages/home/home_page.dart';
import '../view/widgets/auth/login/login_form_widget.dart';
import '../view/widgets/auth/signup/show_error_message_widget.dart';
import '../view/widgets/auth/signup/sign_up_form.dart';
import '../view/widgets/my_alert_dialog_widget.dart';
import '../view/widgets/my_progress_indicador_widget.dart';

class AuthenticationRepositoryController with ChangeNotifier {
  //variables
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _firebaseUser;
  late final String _verificationId = '';

  AuthenticationRepositoryController() {
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
    return _firebaseUser == null ? const HomePage() : const IntroPage();
  }

  // logout user
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    _firebaseUser = null;
    notifyListeners();
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const IntroPage()),
    );
  }

  // sign user up method
  void signUserUp(BuildContext context) async {
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
  Future<void> signUserIn(BuildContext context) async {
    // show loading circle
    showDialog(
      barrierDismissible: false, // Prevent dismissing by tapping outside
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
      // login and block back
      Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
      (Route<dynamic> route) => false,
    );
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

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    // 1) Ensure GoogleSignIn is initialized
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize();

    // 2) Authenticate the user (interactive)
    // authenticate() throws on failure; it returns a GoogleSignInAccount
    final GoogleSignInAccount googleAccount = await googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    // 3) Get the idToken from the account authentication (synchronous)
    final GoogleSignInAuthentication gAuth = googleAccount.authentication;
    final String? idToken = gAuth.idToken;

    // 4) Get an access token for the required scopes using the authorizationClient
    //    This may return null if the user hasn't granted it yet — then we request authorization.
    final authClient = googleSignIn.authorizationClient;
    GoogleSignInClientAuthorization? authorization =
        await authClient.authorizationForScopes(['email']);

    authorization ??= await authClient.authorizeScopes(['email']);

    final String accessToken = authorization.accessToken;


    // 5) Create Firebase credential
    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: accessToken,
    );

    // 6) Sign in to Firebase
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // 7) Optionally write user data to Firestore (merge so we don't overwrite)
    final user = userCredential.user;
    if (user != null) {
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'Email': googleAccount.email,
        'Name': googleAccount.displayName,
        'PhotoURL': googleAccount.photoUrl,
      }, SetOptions(merge: true));
    }

    // 8) Navigate to home (replace the whole stack)
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  } on GoogleSignInException catch (e) {
    // handle known plugin errors (useful for debugging)
    debugPrint('GoogleSignInException: code=${e.code} desc=${e.description} details=${e.details}');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: ${e.description ?? e.code}')),
      );
    }
  } catch (e) {
    debugPrint('Google sign-in failed: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Google: $e')),
      );
    }
  }
}

  Future<void> signOutWithGoogle(BuildContext context) async {
  try {
    // 1) Get the GoogleSignIn singleton instance and ensure it's initialized
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize();

    // 2) Sign out from Google
    await googleSignIn.signOut();

    // 3) Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // 4) Optionally clear any local caches or shared preferences if needed
    // Example:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    // 5) Navigate back to your login screen (replace current navigation stack)
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }

    // 6) (Optional) Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed out successfully')),
    );
  } catch (e) {
    debugPrint('Google sign-out failed: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign out: $e')),
      );
    }
  }
}

}

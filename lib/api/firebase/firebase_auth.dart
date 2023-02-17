import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHandler {
  static Future<String?> signInOrUp(
      {required String email, required String password}) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (signUpError) {
      try {
        if (signUpError is PlatformException) {
          if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);
          }
        }
        return signUpError.toString();
      } catch (error) {
        if (error is PlatformException) {
          return error.code;
        }
        return signUpError.toString();
      }
    }
    return null;
  }

  static Future<String?> googleSignIn() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        return "Couldn't sign in";
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}

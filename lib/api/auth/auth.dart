import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHandler {
  static Future<dynamic> googleSignIn() async {
    GoogleSignInAccount? account;
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      account = await googleSignIn.signIn();
      if (account == null) {
        return "Couldn't sign in";
      }
    } catch (e) {
      return e.toString();
    }
    return account;
  }

  static Future firebaseSignInWithGoogle(GoogleSignInAccount account) async {
    GoogleSignInAuthentication googleSignInAuthentication =
        await account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

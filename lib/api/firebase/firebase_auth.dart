import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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
}

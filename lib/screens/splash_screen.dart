import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solutions/screens/navigable_screens.dart';
import 'package:solutions/api/auth/auth.dart';
import 'package:solutions/widgets/app_icon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_screen/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    if (FirebaseAuth.instance.currentUser == null) {
      GoogleSignInAccount? account = await GoogleSignIn().signInSilently();
      if (account != null) {
        await FirebaseAuthHandler.firebaseSignInWithGoogle(account);
      }
    }
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified) {
      if (mounted) {
        // Navigator.pushNamed(context, NavigableScreens.routeName)
        //     .then((value) => exit(0));
        Navigator.pushNamed(context, AuthScreen.routeName)
            .then((value) => exit(0));
      }
    } else {
      if (mounted) {
        Navigator.pushNamed(context, AuthScreen.routeName)
            .then((value) => exit(0));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(child: AppIcon(size: 110)),
    );
  }
}

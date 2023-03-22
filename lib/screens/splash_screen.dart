import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:solutions/api/firestore/firestore.dart';
import 'package:solutions/screens/navigable_screens.dart';
import 'package:solutions/api/auth/auth.dart';
import 'package:solutions/state_handlers/user/user_handler.dart';
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
    UserHandler userHandler = Provider.of<UserHandler>(context, listen: false);
    if (FirebaseAuth.instance.currentUser != null) {
      userHandler.user = await FirestoreHandler.getUserData();
    }
    if (FirebaseAuth.instance.currentUser != null &&
        userHandler.user?.restaurantID != null) {
      if (mounted) {
        Navigator.pushNamed(context, NavigableScreens.routeName)
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

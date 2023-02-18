import 'dart:io';
import 'package:flutter/material.dart';
import 'package:solutions/widgets/app_icon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen/home_screen.dart';
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

    if (FirebaseAuth.instance.currentUser != null) {
      if (mounted) {
        Navigator.pushNamed(context, HomeScreen.routeName)
            .then((value) => exit(0));
      }
    } else {
      if (mounted) {
        Navigator.pushNamed(context, HomeScreen.routeName)
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
    return const Scaffold(
      body: Center(
        child: AppIcon(size: 110),
      ),
    );
  }
}

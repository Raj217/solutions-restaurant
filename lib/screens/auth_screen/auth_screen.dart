import 'package:flutter/material.dart';
import 'pages/login_page/login_page.dart';
import 'pages/register_page.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/authScreen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [LoginPage(), RegisterPage()],
      ),
    );
  }
}

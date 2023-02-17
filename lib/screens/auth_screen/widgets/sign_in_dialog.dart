import 'package:flutter/material.dart';
import 'package:solutions/screens/auth_screen/widgets/sign_in_form.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/api/firebase/firebase_auth.dart';

class SignInDialog extends StatelessWidget {
  const SignInDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Sign In',
            style: Theme.of(context)
                .textTheme
                .headlineLarge), // TODO: Change Sign In
        const Spacer(flex: 1),
        const SignInOrUpForm(),
        const Spacer(flex: 1),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'sign_in_form.dart';
import 'package:solutions/configs/configs.dart';

class SignInDialog extends StatelessWidget {
  final void Function() onTap;
  const SignInDialog({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Sign In', style: Theme.of(context).textTheme.headlineLarge),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'Register',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: accentColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SignInForm(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

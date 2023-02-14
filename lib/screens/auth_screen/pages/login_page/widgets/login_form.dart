import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/utils/validators.dart';
import 'package:solutions/widgets/buttons/custom_elevated_button.dart';

class LoginForm extends StatefulWidget {
  final bool startFormAnim;
  const LoginForm({Key? key, required this.startFormAnim}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  double firstFormOpacity = 0;
  double secondFormOpacity = 0;
  double buttonScale = 0;
  bool didAnimate = false;
  void startAnim() async {
    // Animate first form
    await Future.delayed(baseDurationDelay);
    setState(() => firstFormOpacity = 1);

    await Future.delayed(mediumAnimDuration);
    setState(() => secondFormOpacity = 1);

    await Future.delayed(mediumAnimDuration);
    setState(() => buttonScale = 1);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.startFormAnim == true && !didAnimate) {
      startAnim();
      didAnimate = true;
    }
    return Form(
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width * 0.8, 300),
        child: Column(
          children: [
            AnimatedOpacity(
              duration: mediumAnimDuration,
              opacity: firstFormOpacity,
              curve: Curves.fastOutSlowIn,
              child: TextFormField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                validator: Validators.isEmailValid,
                textInputAction: TextInputAction.next,
              ),
            ),
            AnimatedOpacity(
              duration: mediumAnimDuration,
              opacity: secondFormOpacity,
              curve: Curves.fastOutSlowIn,
              child: TextFormField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorMaxLines: 2,
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.length < 6) {
                    return 'password must be at least 6 letters long';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            AnimatedScale(
                duration: mediumAnimDuration,
                scale: buttonScale,
                curve: Curves.fastOutSlowIn,
                child: CustomElevatedButton(onTap: () {}, title: 'Login')),
          ],
        ),
      ),
    );
  }
}

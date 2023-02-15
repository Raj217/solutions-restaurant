import 'dart:async';
import 'dart:math';
import 'package:solutions/widgets/buttons/custom_elevated_button.dart';

import '../widgets/rotating_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutions/configs/configs.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Size _screenSize = const Size(0, 0);
  double _height = 0;
  final double logoSize = 90;
  double _scale = 0;
  double _blurRadius = 0;
  bool startFormAnim = false;
  bool didStartAnim = false;
  double divider1Width = 0, divider2Width = 0;
  bool isORTextVisible = false;
  double googleSignInButtonScale = 0;

  void startAnim() async {
    await Future.delayed(baseDurationDelay);
    // Loading the container from top
    setState(() => _height = _screenSize.height * 0.3);

    await Future.delayed(slowAnimDuration);
    // Scaling the logo
    setState(() => _scale = 1);

    await Future.delayed(mediumAnimDuration);
    // Adding background shadow to logo
    setState(() => _blurRadius = 10);

    await Future.delayed(mediumAnimDuration);
    // Start form animation
    setState(() => startFormAnim = true);

    // Ending the form animation
    await Future.delayed(mediumAnimDuration +
        mediumAnimDuration +
        mediumAnimDuration +
        mediumAnimDuration);
    // Divider anim part 1
    setState(() => divider1Width = 50);

    await Future.delayed(fastAnimDuration);
    // OR text setState
    setState(() => isORTextVisible = true);

    await Future.delayed(fastAnimDuration);
    // Divider anim part 2
    setState(() => divider2Width = 50);

    await Future.delayed(fastAnimDuration);
    setState(() => googleSignInButtonScale = 1);
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    if (!didStartAnim) {
      startAnim();
      didStartAnim = true;
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              AnimatedContainer(
                duration: slowAnimDuration,
                height: _height,
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(
                        _screenSize.width * 0.25, _screenSize.height * 0.1),
                    bottomRight: Radius.elliptical(
                        _screenSize.width * 0.25, _screenSize.height * 0.1),
                  ),
                ),
              ),
              SizedBox(height: logoSize),
              LoginForm(startFormAnim: startFormAnim),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: fastAnimDuration,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    height: 1,
                    color: Theme.of(context).colorScheme.secondary,
                    width: divider1Width,
                  ),
                  AnimatedOpacity(
                    opacity: isORTextVisible == true ? 1 : 0,
                    duration: fastAnimDuration,
                    curve: Curves.fastOutSlowIn,
                    child: const Text('  OR  '),
                  ),
                  AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: fastAnimDuration,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    height: 1,
                    color: Theme.of(context).colorScheme.secondary,
                    width: divider2Width,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              AnimatedScale(
                scale: googleSignInButtonScale,
                duration: mediumAnimDuration,
                curve: Curves.fastOutSlowIn,
                child: CustomElevatedButton(
                  onTap: () {},
                  leading: SizedBox(
                      height: logoSize / 3, child: Image.asset(googleImgPath)),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: 'Sign In with Google',
                ),
              )
            ],
          ),
          Positioned(
            top: _height - logoSize / 4,
            left: _screenSize.width / 2 - logoSizeLarge / 2 - logoSize / 3,
            child: AnimatedScale(
              duration: mediumAnimDuration,
              curve: Curves.fastOutSlowIn,
              scale: _scale,
              child: RotatingLogo(
                logoSize: logoSize,
                blurRadius: _blurRadius,
              ),
            ),
          )
        ],
      ),
    );
  }
}

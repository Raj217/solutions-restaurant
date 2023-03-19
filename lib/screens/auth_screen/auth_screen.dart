import 'dart:ui';
import 'widgets/sign_in_or_up_dialog.dart';

import '../../widgets/dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:solutions/configs/configs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solutions/widgets/app_icon.dart';
import 'package:solutions/screens/auth_screen/widgets/animated_join_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String routeName = '/authScreen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignInDialogShown = false;
  final RiveAnimationController _btnAnimationController = OneShotAnimation(
    "active",
    autoplay: false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: kThemeAnimationDuration,
            top: isSignInDialogShown ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 1),
                    const AppIcon(),
                    const Spacer(),
                    Text(
                      'Join Us',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 50),
                    ),
                    const Text('in our journey to serve the world'),
                    const Spacer(flex: 3),
                    SizedBox(
                      height: 200,
                      child: SvgPicture.asset(
                        chefSVGPath,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const Spacer(flex: 3),
                    AnimatedButton(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;
                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isSignInDialogShown = true;
                            });
                            showCustomDialog(context, onValue: (_) {
                              setState(() {
                                isSignInDialogShown = false;
                              });
                            }, child: const SignInOrUpDialog());
                          },
                        );
                      },
                    ),
                    const Spacer(flex: 1),
                    Text(
                      'Copyright ©  2023-2023 Solutions. All rights reserved',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

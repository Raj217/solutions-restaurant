import 'package:flutter/material.dart';
import 'package:solutions/screens/auth_screen/widgets/regsiter_restaurant/register_restaurant.dart';
import 'package:solutions/screens/auth_screen/widgets/sign_in_dialog/sign_in_dialog.dart';
import 'package:solutions/screens/auth_screen/widgets/sign_in_dialog/sign_in_form.dart';
import 'package:solutions/configs/configs.dart';

class SignInOrUpDialog extends StatefulWidget {
  const SignInOrUpDialog({Key? key}) : super(key: key);

  @override
  State<SignInOrUpDialog> createState() => _SignInOrUpDialogState();
}

class _SignInOrUpDialogState extends State<SignInOrUpDialog> {
  final PageController pageController = PageController();

  void onTap(bool isSignIn) {
    if (isSignIn == true) {
      pageController.animateToPage(0,
          duration: kThemeAnimationDuration + kThemeAnimationDuration,
          curve: Curves.easeInOutExpo);
    } else {
      pageController.animateToPage(1,
          duration: kThemeAnimationDuration + kThemeAnimationDuration,
          curve: Curves.easeInOutExpo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: kThemeAnimationDuration,
          bottom: MediaQuery.of(context).viewInsets.bottom / 2.5,
          curve: Curves.easeOut,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.62,
            width: MediaQuery.of(context).size.width * 0.8,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                SignInDialog(onTap: () => onTap(false)),
                RegisterRestaurant(onTap: () => onTap(true)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

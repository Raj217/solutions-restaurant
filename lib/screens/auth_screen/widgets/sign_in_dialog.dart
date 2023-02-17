import 'package:flutter/material.dart';
import 'package:solutions/screens/auth_screen/widgets/sign_in_form.dart';
import 'package:solutions/configs/configs.dart';
import 'sign_up_dialog.dart';

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
        Row(
          children: [
            Expanded(
                child: Divider(
                    color: Theme.of(context).disabledColor, endIndent: 10)),
            const Text('OR'),
            Expanded(
                child: Divider(
                    color: Theme.of(context).disabledColor, indent: 10)),
          ],
        ),
        const Spacer(flex: 1),
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            minimumSize: const Size(double.infinity, 56),
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
          ),
          icon: SizedBox(height: 30, child: Image.asset(googlImgPath)),
          label: const Text("Sign in With Google"),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}

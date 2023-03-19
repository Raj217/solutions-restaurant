import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rive/rive.dart';
import 'package:solutions/api/auth/auth.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/screens/navigable_screens.dart';
import 'package:solutions/utils/validators.dart';
import 'package:solutions/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:solutions/widgets/fields/custom_text_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;

  late SMITrigger confetti;

  void _onCheckRiveInit(Artboard artBoard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artBoard, 'State Machine 1');

    artBoard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artBoard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artBoard, "State Machine 1");
    artBoard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void fireLoading() {
    setState(() {
      isShowConfetti = true;
      isShowLoading = true;
    });
  }

  Future<void> fireSuccess() async {
    success.fire();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isShowLoading = false;
    });
    confetti.fire();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> fireError() async {
    error.fire();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isShowLoading = false;
    });
    reset.fire();
  }

  // TODO: Change Logic
  void signIn() {
    fireLoading();
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (_formKey.currentState!.validate()) {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passController.text,
            );
            fireSuccess();
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushNamed(context, NavigableScreens.routeName);
            });
          } catch (e) {
            Fluttertoast.showToast(msg: e.toString());
            fireError();
          }
        } else {
          fireError();
        }
      },
    );
  }

  void googleSignIn() {
    fireLoading();
    Future.delayed(const Duration(seconds: 1), () async {
      dynamic res = await FirebaseAuthHandler.googleSignIn();
      if (res != null) {
        fireSuccess();
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, NavigableScreens.routeName);
        });
      } else {
        fireError();
        Fluttertoast.showToast(msg: res);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                    label: "Email",
                    validator: Validators.isEmailValid,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email),
                CustomTextField(
                    label: "Admin Password",
                    obscureText: true,
                    validator: Validators.isPasswordValid,
                    controller: _passController,
                    icon: Icons.lock),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: CustomElevatedIconButton(
                    onPressed: signIn,
                    icon: const Icon(CupertinoIcons.arrow_right),
                    label: const Text("Sign in"),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                            color: Theme.of(context).disabledColor,
                            endIndent: 10)),
                    const Text('OR'),
                    Expanded(
                        child: Divider(
                            color: Theme.of(context).disabledColor,
                            indent: 10)),
                  ],
                ),
                const SizedBox(height: 20),
                CustomElevatedIconButton(
                  onPressed: googleSignIn,
                  icon: SizedBox(height: 30, child: Image.asset(googlImgPath)),
                  label: const Text("Sign in With Google"),
                ),
              ],
            ),
          ),
          isShowLoading
              ? CustomPositioned(
                  child: RiveAnimation.asset(
                    riveAnimCheckPath,
                    fit: BoxFit.cover,
                    onInit: _onCheckRiveInit,
                  ),
                )
              : const SizedBox(),
          isShowConfetti
              ? CustomPositioned(
                  scale: 6,
                  child: RiveAnimation.asset(
                    riveAnimConfettiPath,
                    onInit: _onConfettiRiveInit,
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 0,
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(scale: scale, child: child),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

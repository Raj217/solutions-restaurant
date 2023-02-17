import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/utils/validators.dart';

class SignInOrUpForm extends StatefulWidget {
  const SignInOrUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInOrUpForm> createState() => _SignInOrUpFormState();
}

class _SignInOrUpFormState extends State<SignInOrUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  void singIn(BuildContext context) {
    fireLoading();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (_formKey.currentState!.validate()) {
          fireSuccess();
        } else {
          fireError();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email", style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  validator: Validators.isEmailValid,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email, size: 20, color: accentColor),
                  ),
                ),
              ),
              const Text("Password", style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  obscureText: true,
                  validator: Validators.isPasswordValid,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock, size: 20, color: accentColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: () => singIn(context),
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
                  icon: const Icon(CupertinoIcons.arrow_right),
                  label: const Text("Sign In / Sign Up"),
                ),
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

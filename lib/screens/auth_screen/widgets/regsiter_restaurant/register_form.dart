import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solutions/screens/navigable_screens.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:solutions/api/auth/auth.dart';
import 'package:solutions/model/restaurant.dart';
import 'package:solutions/state_handlers/user/user_handler.dart';
import 'package:solutions/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/utils/validators.dart';
import 'package:solutions/widgets/location_viewer/location_viewer.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:solutions/widgets/fields/custom_text_field.dart';
import 'package:solutions/model/app_user.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<latLng.LatLng?> location = ValueNotifier(null);

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

  void hideLoading() {
    setState(() {
      isShowConfetti = false;
      isShowLoading = false;
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

  void register() {
    fireLoading();
    Future.delayed(const Duration(seconds: 1), () async {
      if (!_formKey.currentState!.validate()) {
        fireError();
      } else {
        if (location.value == null) {
          Fluttertoast.showToast(msg: 'Location not found!');
          hideLoading();
          return;
        }
        try {
          if (FirebaseAuth.instance.currentUser == null) {
            /// Try Creating the user
            try {
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passController.text,
              );
              await FirebaseAuth.instance.currentUser!.sendEmailVerification();
              Fluttertoast.showToast(
                  msg: 'Please check your email box to verify your email');
              hideLoading();
              return;
            } catch (e) {
              if (e is FirebaseAuthException &&
                  e.code == "email-already-in-use") {
                /// Existing user
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passController.text,
                  );
                } catch (e) {
                  Fluttertoast.showToast(msg: e.toString());
                  hideLoading();
                  return;
                }
              }
              Fluttertoast.showToast(msg: e.toString());
              hideLoading();
              return;
            }
          }
          User user = FirebaseAuth.instance.currentUser!;
          user.reload();
          if (!user.emailVerified) {
            try {
              await user.sendEmailVerification();
              Fluttertoast.showToast(
                  msg: 'Please check your email box to verify your email');
            } catch (e) {
              Fluttertoast.showToast(msg: e.toString());
            }
            hideLoading();
            return;
          }
          UserHandler userHandler =
              Provider.of<UserHandler>(context, listen: false);

          /// Adding user to firebase
          AppUser appUser = AppUser(
            emailID: FirebaseAuth.instance.currentUser!.email,
            role: Role.restaurantAdmin,
          );
          String? res = await userHandler.addUserToFirestore(appUser);
          if (res != null) {
            /// Old User
            Fluttertoast.showToast(msg: res);
            fireError();
            return;
          }

          /// New User
          Restaurant restaurant = Restaurant(
            name: _nameController.text,
            location: location.value!,
            adminID: FirebaseAuth.instance.currentUser!.uid,
          );
          res = await userHandler.addRestaurantToFirestore(restaurant);
          if (res == null) {
            fireSuccess();

            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushNamed(context, NavigableScreens.routeName);
            });
          } else {
            Fluttertoast.showToast(msg: res);
          }
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
          fireError();
        }
      }
    });
  }

  void googleSignIn() {
    fireLoading();
    Future.delayed(const Duration(seconds: 1), () async {
      dynamic res = await FirebaseAuthHandler.googleSignIn();
      if (res.runtimeType is! String) {
        try {
          await FirebaseAuthHandler.firebaseSignInWithGoogle(res);
          hideLoading();
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
          fireError();
        }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedIconButton(
                      onPressed: googleSignIn,
                      minSize: const Size(20, 40),
                      icon: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            child: Image.asset(googlImgPath),
                          ),
                          if (FirebaseAuth.instance.currentUser != null)
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(
                                CupertinoIcons.checkmark_alt,
                                color: Colors.green,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (FirebaseAuth.instance.currentUser != null)
                      GestureDetector(
                        onTap: () async {
                          fireLoading();
                          await GoogleSignIn().signOut();
                          await FirebaseAuth.instance.signOut();
                          hideLoading();
                        },
                        child: Text(
                          'Change User',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: accentColor),
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 10),
                if (FirebaseAuth.instance.currentUser == null)
                  CustomTextField(
                      label: "Admin Email",
                      validator: Validators.isEmailValid,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email),
                if (FirebaseAuth.instance.currentUser == null)
                  CustomTextField(
                      label: "Admin Password",
                      obscureText: true,
                      validator: Validators.isPasswordValid,
                      controller: _passController,
                      icon: Icons.lock),
                CustomTextField(
                    label: "Restaurant Name",
                    validator: Validators.isEmpty,
                    controller: _nameController,
                    icon: Icons.restaurant),
                const Text('Location',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                    height: 200,
                    child: LocationViewer(
                      location: location,
                      validator: Validators.isEmpty,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: CustomElevatedIconButton(
                    onPressed: register,
                    icon: const Icon(CupertinoIcons.arrow_right),
                    label: const Text("Register"),
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

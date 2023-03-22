import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rive/rive.dart';
import 'package:solutions/configs/configs.dart';

class CustomLoadingOverlay extends StatelessWidget {
  final Widget child;
  const CustomLoadingOverlay({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.transparent,
      overlayWidget: const Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: RiveAnimation.asset(
            riveAnimCheckPath,
            stateMachines: ["Loading"],
          ),
        ),
      ),
      child: child,
    );
  }
}

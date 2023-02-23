import 'dart:ui';

import 'package:rive/rive.dart';

class RiveUtils {
  static void changeSMIBoolState(SMIBool input, Duration duration) {
    input.change(true);
    Future.delayed(
      duration,
      () => input.change(false),
    );
  }

  static SMIBool getRiveInputBool(Artboard artboard,
      {required String stateMachineName, required String inputName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    return controller.findInput<bool>(inputName) as SMIBool;
  }
}

import 'package:rive/rive.dart';

class RiveUtils {
  static void changeSMIBoolState(SMIBool input) {
    input.change(true);
    Future.delayed(
      const Duration(seconds: 2),
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

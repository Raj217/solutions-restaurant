import 'package:rive/rive.dart';
import '../../configs/configurations/constants.dart';

RiveModel menu = RiveModel<SMIBool>(
  src: riveAnimMenuButtonPath,
  artboard: "MENU",
  inputName: 'isOpen',
  stateMachineName: "MENU_Interactivity",
  duration: const Duration(seconds: 1),
);

List<RiveModel> bottomNavbarMenuItems = [
  RiveModel<SMIBool>(
    src: riveAnimIconsPath,
    artboard: "HOME",
    inputName: 'active',
    stateMachineName: "HOME_interactivity",
    duration: const Duration(seconds: 2),
  ),
  RiveModel<SMIBool>(
    src: riveAnimMapPath,
    artboard: "MAP",
    inputName: 'active',
    stateMachineName: "MAP_Interactivity",
    duration: const Duration(seconds: 2),
  ),
  RiveModel<SMIBool>(
    src: riveAnimIconsPath,
    artboard: "REFRESH/RELOAD",
    inputName: 'active',
    stateMachineName: "RELOAD_Interactivity",
    duration: const Duration(seconds: 2),
  ),
  RiveModel<SMIBool>(
    src: riveAnimIconsPath,
    artboard: "LIKE/STAR",
    inputName: 'active',
    stateMachineName: "STAR_Interactivity",
    duration: const Duration(seconds: 2),
  ),
  RiveModel<SMIBool>(
    src: riveAnimIconsPath,
    artboard: "USER",
    inputName: 'active',
    stateMachineName: "USER_Interactivity",
    duration: const Duration(seconds: 2),
  ),
];

class RiveModel<SMIType> {
  String src, artboard, stateMachineName, inputName;
  SMIType? status;
  Duration duration;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.inputName,
    this.status,
    required this.duration,
  });

  set setStatus(SMIType state) {
    status = state;
  }
}

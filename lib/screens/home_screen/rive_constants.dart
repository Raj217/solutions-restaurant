import 'package:rive/rive.dart';
import '../../configs/configurations/constants.dart';

List<Menu> bottomNavbarMenuItems = [
  Menu(
    title: "Home",
    rive: RiveModel(
        src: riveAnimIconsPath,
        artboard: "HOME",
        inputName: 'active',
        stateMachineName: "HOME_interactivity"),
  ),
  Menu(
    title: "Map",
    rive: RiveModel(
        src: riveAnimMapPath,
        artboard: "MAP",
        inputName: 'active',
        stateMachineName: "MAP_Interactivity"),
  ),
  Menu(
    title: "Updates",
    rive: RiveModel(
        src: riveAnimIconsPath,
        artboard: "REFRESH/RELOAD",
        inputName: 'active',
        stateMachineName: "RELOAD_Interactivity"),
  ),
  Menu(
    title: "Favorites",
    rive: RiveModel(
        src: riveAnimIconsPath,
        artboard: "LIKE/STAR",
        inputName: 'active',
        stateMachineName: "STAR_Interactivity"),
  ),
  Menu(
    title: "User",
    rive: RiveModel(
        src: riveAnimIconsPath,
        artboard: "USER",
        inputName: 'active',
        stateMachineName: "USER_Interactivity"),
  ),
];

class RiveModel {
  final String src, artboard, stateMachineName, inputName;
  late SMIBool? status;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.inputName,
    this.status,
  });

  set setStatus(SMIBool state) {
    status = state;
  }
}

class Menu {
  final String title;
  final RiveModel rive;

  Menu({required this.title, required this.rive});
}

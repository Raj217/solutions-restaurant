import 'package:rive/rive.dart';
import 'constants.dart';

RiveModel getRiveMenu() => RiveModel<SMIBool>(
      title: 'Menu',
      src: riveAnimMenuButtonPath,
      artboard: "MENU",
      inputName: 'isOpen',
      stateMachineName: "MENU_Interactivity",
      duration: const Duration(seconds: 1),
    );

RiveModel getRiveHome() => RiveModel<SMIBool>(
      title: 'Home',
      src: riveAnimIconsPath,
      artboard: "HOME",
      inputName: 'active',
      stateMachineName: "HOME_interactivity",
      duration: const Duration(seconds: 2),
    );

RiveModel getRiveMap() => RiveModel<SMIBool>(
      title: 'Map',
      src: riveAnimMapPath,
      artboard: "MAP",
      inputName: 'active',
      stateMachineName: "MAP_Interactivity",
      duration: const Duration(seconds: 2),
    );

RiveModel getRiveRefresh() => RiveModel<SMIBool>(
      title: 'Updates',
      src: riveAnimIconsPath,
      artboard: "REFRESH/RELOAD",
      inputName: 'active',
      stateMachineName: "RELOAD_Interactivity",
      duration: const Duration(seconds: 2),
    );

RiveModel getRiveLike() => RiveModel<SMIBool>(
      title: 'Favorite',
      src: riveAnimIconsPath,
      artboard: "LIKE/STAR",
      inputName: 'active',
      stateMachineName: "STAR_Interactivity",
      duration: const Duration(seconds: 2),
    );

RiveModel getRiveUser() => RiveModel<SMIBool>(
      title: 'User',
      src: riveAnimIconsPath,
      artboard: "USER",
      inputName: 'active',
      stateMachineName: "USER_Interactivity",
      duration: const Duration(seconds: 2),
    );

RiveModel getRiveSettings() => RiveModel<SMIBool>(
      title: 'Settings',
      src: riveAnimIconsPath,
      artboard: "SETTINGS",
      inputName: 'active',
      stateMachineName: "SETTINGS_Interactivity",
      duration: const Duration(seconds: 2),
    );

RiveModel getRiveNotifications() => RiveModel<SMIBool>(
      title: 'Notifications',
      src: riveAnimIconsPath,
      artboard: "BELL",
      inputName: 'active',
      stateMachineName: "BELL_Interactivity",
      duration: const Duration(seconds: 2),
    );

RiveModel getRiveSearch() => RiveModel<SMIBool>(
      title: 'Search',
      src: riveAnimIconsPath,
      artboard: "SEARCH",
      inputName: 'active',
      stateMachineName: "SEARCH_Interactivity",
      duration: const Duration(seconds: 2),
    );
RiveModel getRiveContactUs() => RiveModel<SMIBool>(
      title: 'Contact Us',
      src: riveAnimIconsPath,
      artboard: "CHAT",
      inputName: 'active',
      stateMachineName: "CHAT_Interactivity",
      duration: const Duration(seconds: 2),
    );

class RiveModel<SMIType> {
  String src, artboard, stateMachineName, inputName, title;
  SMIType? status;
  Duration duration;

  RiveModel({
    required this.title,
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

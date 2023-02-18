import 'package:flutter/material.dart';
import 'package:solutions/screens/home_screen/rive_constants.dart';
import 'package:solutions/screens/home_screen/widgets/bottom_navbar/widgets/bottom_navbar_item.dart';
import 'package:solutions/utils/rive_utils.dart';

class BottomNavbar extends StatefulWidget {
  final void Function(int)? onTap;
  const BottomNavbar({Key? key, this.onTap}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  Menu selectedNav = bottomNavbarMenuItems.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(3, 5),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(bottomNavbarMenuItems.length, (index) {
            Menu navBarItem = bottomNavbarMenuItems[index];
            return BottomNavbarItem(
                navBar: navBarItem,
                onTap: () {
                  RiveUtils.changeSMIBoolState(navBarItem.rive.status!);
                  setState(() {
                    selectedNav = navBarItem;
                  });
                  if (widget.onTap != null) {
                    widget.onTap!(index);
                  }
                },
                riveOnInit: (artboard) {
                  navBarItem.rive.status = RiveUtils.getRiveInputBool(artboard,
                      stateMachineName: navBarItem.rive.stateMachineName,
                      inputName: navBarItem.rive.inputName);
                },
                selectedNav: selectedNav);
          })
        ],
      ),
    );
  }
}

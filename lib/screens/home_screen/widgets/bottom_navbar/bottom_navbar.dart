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
  RiveModel selectedNav = bottomNavbarMenuItems.first;
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
            RiveModel navBarItem = bottomNavbarMenuItems[index];
            return BottomNavbarItem(
                navBar: navBarItem,
                onTap: () {
                  RiveUtils.changeSMIBoolState(
                      navBarItem.status!, navBarItem.duration);
                  setState(() {
                    selectedNav = navBarItem;
                  });
                  if (widget.onTap != null) {
                    widget.onTap!(index);
                  }
                },
                riveOnInit: (artboard) {
                  navBarItem.status = RiveUtils.getRiveInputBool(artboard,
                      stateMachineName: navBarItem.stateMachineName,
                      inputName: navBarItem.inputName);
                },
                selectedNav: selectedNav);
          })
        ],
      ),
    );
  }
}

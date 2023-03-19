import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solutions/state_handlers/pages/page_handler.dart';
import 'widgets/bottom_navbar_item.dart';
import 'package:solutions/utils/rive_utils.dart';
import 'package:solutions/configs/configs.dart';

class BottomNavbar extends StatefulWidget {
  final List<RiveModel> bottomNavbarMenuItems;
  const BottomNavbar({Key? key, required this.bottomNavbarMenuItems})
      : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageHandler>(
        builder: (BuildContext context, PageHandler pageHandler, _) {
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
            ...List.generate(widget.bottomNavbarMenuItems.length, (index) {
              RiveModel navBarItem = widget.bottomNavbarMenuItems[index];
              return BottomNavbarItem(
                  navBar: navBarItem,
                  onTap: () {
                    pageHandler.currentIndex = index;
                    RiveUtils.changeSMIBoolState(
                        navBarItem.status!, navBarItem.duration);
                  },
                  riveOnInit: (artboard) {
                    navBarItem.status = RiveUtils.getRiveInputBool(artboard,
                        stateMachineName: navBarItem.stateMachineName,
                        inputName: navBarItem.inputName);
                  },
                  selectedNav:
                      widget.bottomNavbarMenuItems[pageHandler.currentIndex]);
            })
          ],
        ),
      );
    });
  }
}

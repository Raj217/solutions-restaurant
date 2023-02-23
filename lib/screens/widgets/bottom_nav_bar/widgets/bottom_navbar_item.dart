import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:solutions/configs/configs.dart';
import 'animated_bar.dart';

class BottomNavbarItem extends StatelessWidget {
  const BottomNavbarItem(
      {super.key,
      required this.navBar,
      required this.onTap,
      required this.riveOnInit,
      required this.selectedNav});

  final RiveModel navBar;
  final VoidCallback onTap;
  final ValueChanged<Artboard> riveOnInit;
  final RiveModel selectedNav;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: selectedNav == navBar),
          SizedBox(
            height: 36,
            width: 36,
            child: Opacity(
              opacity: selectedNav == navBar ? 1 : 0.5,
              child: RiveAnimation.asset(
                navBar.src,
                artboard: navBar.artboard,
                onInit: riveOnInit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

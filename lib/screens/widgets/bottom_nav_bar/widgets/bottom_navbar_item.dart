import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:solutions/configs/configs.dart';
import '../../animated/animated_bar.dart';

class BottomNavbarItem extends StatefulWidget {
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
  State<BottomNavbarItem> createState() => _BottomNavbarItemState();
}

class _BottomNavbarItemState extends State<BottomNavbarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: widget.selectedNav == widget.navBar),
          SizedBox(
            height: 36,
            width: 36,
            child: Opacity(
              opacity: widget.selectedNav == widget.navBar ? 1 : 0.5,
              child: RiveAnimation.asset(
                widget.navBar.src,
                artboard: widget.navBar.artboard,
                onInit: widget.riveOnInit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

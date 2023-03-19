import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(bottom: 2),
      duration: kThemeAnimationDuration,
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

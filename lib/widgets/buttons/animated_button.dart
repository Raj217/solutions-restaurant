import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:solutions/configs/configs.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    Key? key,
    required RiveAnimationController btnAnimationController,
    required this.press,
  })  : _btnAnimationController = btnAnimationController,
        super(key: key);

  final RiveAnimationController _btnAnimationController;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 64,
        width: 236,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 10.0, //extend the shadow
                  offset: const Offset(
                    0.0,
                    10.0,
                  ),
                )
              ]),
              child: RiveAnimation.asset(
                riveAnimButtonPath,
                controllers: [_btnAnimationController],
              ),
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.arrow_right),
                  const SizedBox(width: 8),
                  Text(
                    "Join",
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

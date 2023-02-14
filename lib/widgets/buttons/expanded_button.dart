import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final void Function() onTap;
  final Widget child;
  final Color backgroundColor;
  final double size;
  const ExpandedButton(
      {Key? key,
      required this.onTap,
      required this.child,
      this.size = 50,
      this.backgroundColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.rectangle,
            size: size,
            color: backgroundColor,
          ),
          child
        ],
      ),
    );
  }
}

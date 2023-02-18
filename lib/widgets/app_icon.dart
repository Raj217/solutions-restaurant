import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final double size;
  const AppIcon({Key? key, this.size = 90}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.09),
            spreadRadius: size / 6,
            blurRadius: size / 4.5,
          )
        ],
        borderRadius: BorderRadius.circular(size),
      ),
      child: Icon(Icons.ac_unit_rounded, size: size / 1.8),
    );
  }
}
